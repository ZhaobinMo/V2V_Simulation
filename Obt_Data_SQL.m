clear;
global dTime
dTime = csvread('100kdTime.csv');

%Generate random trip segment
T = 300; % Simulation Time(s)
N = 24; % Num of Vehicles in th network
numInterv = T*10;
DevTrip = g_Randon_N(N,T);
Position = cell(length(DevTrip(:,1)),1);
S_plot_Rand = 1;%Plot the trajectory

%Set preferences with setdbprefs.
setdbprefs('DataReturnFormat', 'table');
setdbprefs('NullNumberRead', 'NaN');
setdbprefs('NullStringRead', 'null');


%Make connection to database.  Note that the password has been omitted.
%Using ODBC driver.
conn = database('Sql', 'zhaoding', '');


for i=1:length(DevTrip(:,1))
    Current_DT = DevTrip(i,:);
    idx = find((dTime(:,1)==Current_DT(1)&dTime(:,2)==Current_DT(2)));
    Current_dTime = dTime(idx,3);
    StartTime_Pool = round((Current_dTime/10 - numInterv)*0.9);
    StartTime_idx = randi([StartTime_Pool StartTime_Pool],1);
 
%Read data from database.


curs = exec(conn, ['Select ROW_NUMBER() over (order by Device, Trip) as rownum,Device,Trip'...
    ',Time,Latitude,Longitude  From "SpFot"."dbo".DataDas Where'...
    ' Device=' num2str(DevTrip(i,1)) ' and Trip=' num2str(DevTrip(i,2)) ...
    ' Order by Device,Trip' ]);
curs = fetch(curs);
Temp = curs.Data;
Position{i} = Temp(Temp.rownum>=StartTime_idx & Temp.rownum<StartTime_idx+numInterv,5:6);
close(curs);

%Assign data to output variable

end

%Close database connection.
close(conn);

%Clear variables
clear curs conn

if S_plot_Rand == 1
    plot_Rand(Position);
end