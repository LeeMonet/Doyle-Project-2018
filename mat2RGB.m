function rgb = mat2RGB(mat, threshhold)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

mat(mat < threshhold) = threshhold;


imagesc(mat);
colormap jet
C = colormap;  % Get the figure's colormap.
L = size(C,1);

% Scale the matrix to the range of the map.
Gs = round(interp1(linspace(min(mat(:)),max(mat(:)),L),1:L,mat));
rgb = reshape(C(Gs,:),[size(Gs) 3]); % Make RGB image from scaled.
end

