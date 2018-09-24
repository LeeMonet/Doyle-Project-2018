function  F = createMovie(rgb, sz, G)
%createMovie Make movie of disturbance data
%   Detailed explanation goes here
[l time n] = size(rgb);

for i = 1:time
   data = rgb(:, i, :);
   data = reshape(data,[l n]);
   F(i) = createFrame(data, sz(:, i), G, i);
end

end

