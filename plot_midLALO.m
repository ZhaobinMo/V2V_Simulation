%Plot the distribution of the central point
clear;
midLALO = csvread('midLALO.csv');
Margin = 1.1;
figure(1);
plot(midLALO(:,4),midLALO(:,3),'.w','markersize',0.1);
set(gcf,'color','w');
%plot google map
xlim = [-83.82,-83.64];ylim = [42.22,42.34];
New_xlim(1) = sum(xlim)/2 - (xlim(2)-xlim(1))/2*Margin;
New_xlim(2) = sum(xlim)/2 + (xlim(2)-xlim(1))/2*Margin;
New_ylim(1) = sum(ylim)/2 - (ylim(2)-ylim(1))/2*Margin;
New_ylim(2) = sum(ylim)/2 + (ylim(2)-ylim(1))/2*Margin;
axis([New_xlim New_ylim]);

xlabel('Longitude');
ylabel('Latitude');
plot_google_map('APIKey','AIzaSyDFTvS9Thk9InCJbjDqjWQ6_wbyFlZxlXA ','MapType','satellite');
