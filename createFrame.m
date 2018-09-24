function F = createFrame(rgb, sz, G, t)
%createFrame helper to create Movie. Creates frames
%   Detailed explanation goes here

%% Create Colors

%% do graph
p = plot(G, 'NodeLabel', {}, 'EdgeColor', 'black');
n = numnodes(G);

hold on
p.MarkerSize = 10 * sz + 4;
for i = 1:n
    highlight(p,i,'NodeColor',rgb(i,:));
end
colorbar
note = sprintf('T = %g', t);
text(0.5, .3, note) 
hold off

F = getframe;

end

