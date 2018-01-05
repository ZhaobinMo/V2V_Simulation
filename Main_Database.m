%%Connect to the database and get the trajectory you want

clear;
global dTime
dTime = csvread('QualifiedTrip_dTime.csv',1,0);

%Generate random trip segment
T = 300; % Simulation Time(s)
N = 24; % Num of Vehicles in th network


numInterv = T*10; %Cause the time interval in database is 0.1s
DevTrip = g_Randon_N(N,T); %Device: The vehicle ID; Trip: A vehicle can have different trip
Position = cell(length(DevTrip(:,1)),1);
S_plot_Rand = 1;%Plot the trajectory if it equals 1
S_plot_Heading = 1;%Plot the heading if it equals 1

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'table');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');

%Belows are mostly generated autonomously
%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('Sql', 'zhaoding', '');


for i=1:length(DevTrip(:,1))
    disp(['i= ' num2str(i)]);
    
    
    %Read data from database.
    flag_query = 1;
    while flag_query == 1
        
        curs = exec(conn, ['Select ROW_NUMBER() over (order by Time) as rownum,Device,Trip'...
            ',Time,LatitudeWsu,LongitudeWsu,GpsHeadingWsu,GpsSpeedWsu '...
            '  From "SpFot"."dbo".DataWsu Where'...
            ' Device=' num2str(DevTrip(i,1)) ' and Trip=' num2str(DevTrip(i,2)) ...
            ' Order by Time' ]);
        curs = fetch(curs);
        Temp = curs.Data;
        
        Current_DT = DevTrip(i,:);
        idx = find((dTime(:,1)==Current_DT(1)&dTime(:,2)==Current_DT(2)));
        Current_dTime = dTime(idx,3);
        StartTime_Pool = round((Current_dTime - numInterv)*0.9);
        StartTime_idx = randi([1 StartTime_Pool],1);
        
        Position{i} = Temp(Temp.rownum>=StartTime_idx & Temp.rownum<StartTime_idx+numInterv,5:8);
        Heading = Position{i}.GpsHeadingWsu;
        dHeading = zeros(length(Heading)-1,1);
        
        for j=1:length(dHeading)
            dHeading(j) = min(    abs(Heading(j+1)-Heading(j)) , ...
                360 - abs(Heading(j+1)-Heading(j))   ); %The Heading difference
        end
        
        if max(dHeading) < 10
            flag_query = 0;
        else
            % Change another set of random DevTrip (Only the left set)
            flag_G_Random = 1;
            while flag_G_Random == 1
                DevTrip_New = g_Randon_N(N-i+1,T);
                flag_G_Random = 0; % ALl the set can be re-chosen
                if i > 1 % if i=1, flag_G_Random = 0
                    
                    for j=1:i-1
                        DevTrip_Same = find(DevTrip_New(:,1)==DevTrip(j,1) & ...
                            DevTrip_New(:,2)==DevTrip(j,2));
                        if ~isempty (DevTrip_Same)
                            flag_G_Random = 1;
                        end
                    end% Make sure there is no repulicate
                end
            end
            DevTrip(i:end,:) = DevTrip_New;
        end
        
        
    end
    
    
    
    close(curs);
    
    %Assign data to output variable
    
end

%Close database connection.
close(conn);

%Clear variables
clear curs conn

close all;
if S_plot_Rand == 1
    plot_Rand(Position);
end

if S_plot_Heading == 1
    if N == 24
        row = 6; col = 4;
    elseif N == 38
        row = 10; col = 4;
    elseif N == 50
        row = 10; col = 5;
    end
    
    for i=1:N
        figure(2);
        title('Heading Angle-t');
        subplot(row,col,i);
        plot(Position{i}.GpsHeadingWsu,'.');
    end
    
end


% %Check by ploting
% figure(3);
% f_PlotTraj([Position{3}.LatitudeWsu,Position{3}.LongitudeWsu,...
%     Position{3}.LatitudeWsu,Position{3}.LongitudeWsu]);