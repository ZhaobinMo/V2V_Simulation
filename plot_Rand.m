function [ output_args ] = plot_Rand( Position )
% Plot the trajectory
TJ_MAX = length(Position);
figure(1);
Margin = 1.1;
ColorOrder = makeColorMap([0 1 0],[1 0 0],[0 0 1],TJ_MAX);


%Plot the first point (as the original point)
% scatter(Position{1}.LongitudeWsu(1),Position{1}.LatitudeWsu(1),20,[1,1,1],'filled');
scatter(Position{1}.LongitudeWsu(1),Position{1}.LatitudeWsu(1),30,'+w');

%Plot the trajectory in one map
for i=1:TJ_MAX
    disp(['i = ' num2str(i)]);
    LoLa = [Position{i}.LongitudeWsu,Position{i}.LatitudeWsu];
    %    NBus = length(LoLa(:,1));
    
    % ColorOrder_S = makeColorMap([0,0,0],[1,1,1],NBus);
    % ColorOrder_L = makeColorMap([1,0,0],[1,1,1],NBus);
    hold on;
    scatter(LoLa(1,1),LoLa(1,2),50,'markeredgecolor','w');
    scatter(LoLa(end,1),LoLa(end,2),50,'d','markeredgecolor','w');
    plot(LoLa(:,1),LoLa(:,2),'linewidth',2,'color',ColorOrder(i,:));
    
    %     for j=NBus:-5:1
    %     plot(LoLa(j,2),LoLa(j,1),'.','MarkerSize',10,'color',ColorOrder_S(j,:));
    %     plot(LoLa(j,4),LoLa(j,3),'.','MarkerSize',10,'color',ColorOrder_L(j,:));
    %     hold on;
    %     end
    
end
xlim = [-83.82,-83.64];ylim = [42.22,42.34];
New_xlim(1) = sum(xlim)/2 - (xlim(2)-xlim(1))/2*Margin;
New_xlim(2) = sum(xlim)/2 + (xlim(2)-xlim(1))/2*Margin;
New_ylim(1) = sum(ylim)/2 - (ylim(2)-ylim(1))/2*Margin;
New_ylim(2) = sum(ylim)/2 + (ylim(2)-ylim(1))/2*Margin;
axis([New_xlim New_ylim]);

xlabel('Longitude(deg)');
ylabel('Latitude(deg)');
set(gca,'fontsize',18);
plot_google_map('APIKey','AIzaSyDFTvS9Thk9InCJbjDqjWQ6_wbyFlZxlXA ','MapType','satellite');

%    lat = [42.365 42.367];
%    lon = [-83.70232 -83.70232];
%    plot(lon,lat,'linewidth',16);
% axis([-83.705 -83.699 42.364 42.367]);
%   plot_google_map()


end

