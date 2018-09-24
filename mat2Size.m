function [sz] = mat2Size(mat, threshhold)
%UNTITLED6 Summary of this function goes here
%   mat disturbance data. I assume that it is negative
sz = mat;
sz(mat < threshhold) = threshhold;
sz = abs(sz);
mx = max(sz(:))
sz = sz/mx;
sz = 1- sz;
sz(sz < .1 ) = .1;

end

