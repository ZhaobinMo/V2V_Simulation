function [ output_args ] = f_PlotTraj( LaLo)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
addpath('C:\Users\Zhaobin\Documents\StudyinUM\LaLo12');
Margin = 1.1;
xlim = [min([LaLo(:,2)' LaLo(:,4)']) max([LaLo(:,2)' LaLo(:,4)'])];
ylim = [min([LaLo(:,1)' LaLo(:,3)']) max([LaLo(:,1)' LaLo(:,3)'])];
NBus = length(LaLo(:,1));
New_xlim(1) = sum(xlim)/2 - (xlim(2)-xlim(1))/2*Margin;
New_xlim(2) = sum(xlim)/2 + (xlim(2)-xlim(1))/2*Margin;
New_ylim(1) = sum(ylim)/2 - (ylim(2)-ylim(1))/2*Margin;
New_ylim(2) = sum(ylim)/2 + (ylim(2)-ylim(1))/2*Margin;
ColorOrder_S = makeColorMap([0,0,1],[1,1,1],NBus);
ColorOrder_L = makeColorMap([1,0,0],[1,1,1],NBus);
figure(1);
for j=NBus:-5:1
    plot(LaLo(j,2),LaLo(j,1),'.','MarkerSize',10,'color',ColorOrder_S(j,:));
    plot(LaLo(j,4),LaLo(j,3),'.','MarkerSize',10,'color',ColorOrder_L(j,:));
    hold on;
end
axis([New_xlim New_ylim]);
plot_google_map('APIKey','AIzaSyDFTvS9Thk9InCJbjDqjWQ6_wbyFlZxlXA ','MapType','satellite');
xlabel('Longitude');
ylabel('Latitude');




end

