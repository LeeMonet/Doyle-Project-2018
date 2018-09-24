function [consumption, x] = createConsumption(tau)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

data = zeros(1, 24);
data(:, 1:3) = linspace(34,32,3);
data(:, 4:10) = linspace(33,45,7);
data(:, 11:15) = linspace(47,51,5);
data(:, 16:18) = linspace(50,49,3);
data(:, 19:24) = linspace(47,34,6);

x = 0:tau:24; %create values for each time step

consumption = [data(1)];
for i = x(2:end)
   t = ceil(i);
   consumption = [consumption, data(t)];
end  


 
    %https://www.eia.gov/realtime_grid/#/data/graphs?end=20180813T15&start=20180806T22&bas=0&regions=g04&timeZone=Pacific

end

