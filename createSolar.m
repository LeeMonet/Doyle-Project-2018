function [norm, x] = createSolar(tau,sunrise, sun_time, scale_factor)
%createSolar creates Solar distribution
%   Detailed explanation goes here


x = 0:tau:24; %create enough values to cover all time steps
norm = normpdf(x,12,2);

%Set times when sun is down to 0
indx = x < sunrise;
norm(indx) = 0;
indx = x > (sunrise + sun_time);
norm(indx) = 0; 

%scale if desired
norm = norm * scale_factor;
end

