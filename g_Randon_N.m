function [ DevTrip ] = g_Randon_N( N,t )
% Generate random trip idx from the Trip_Summary.csv
% N: The number of vehicle in the network from 1 to 100
% t:The simulation duration
global dTime;
St_Search = find(dTime(:,end)>1.1*t*10,1,'first');% 1.1 is the margin
Area_Search = dTime(St_Search:end,[1 2]);
idx = randi(length(Area_Search(:,1)),1,N);
DevTrip = Area_Search(idx,:);%the device,trip that are choosen









% 
% 
% 
% 
% 
% 
% Sum_Device = length(TripNumofDevice(:,1));
% dEvice_idx = randi(Sum_Device,1,N);
% Rand_Trip(:,1) = TripNumofDevice(dEvice_idx,1);
% for i=1:length(Rand_Trip(:,1))
%     Current_TripSum = TripNumofDevice(TripNumofDevice(:,1)==Rand_Trip(i,1),2);
%     iDx = randi(Current_TripSum,1); %Like, generate 5 num from 1:25, say 6
%     bIg_idx = find(Trip_TimeMAX(:,1)==Rand_Trip(i,1),iDx);%The 6th (Device,Trip)
%     rEal_idx = bIg_idx(end);%Its idx in the file Trip_TimeMAX
%     
%     
%     % Find alternate trip if the sum_time is too small
%     if iDx >= round(Current_TripSum/2)
%         dIrection = -1;
%     else
%         dIrection = 1;
%     end
%     if round(Trip_TimeMAX(rEal_idx,3)/100) < t*0.9%
%         while round(Trip_TimeMAX(rEal_idx,3)/100) < t*0.9
%             rEal_idx = rEal_idx + dIrection;
%         end
%     end%Change the idx in the file Trip_TimeMAX until the dTime exceeds t
%     Rand_Trip(i,2) = Trip_TimeMAX(rEal_idx,2);
% end
% 

