function connectedGraph = createConnectedGraph(n, k)
%createConnectedGraph creates a connected graph +/- 5% of n
%  https://www.cs.purdue.edu/homes/dgleich/demos/matlab/random_graphs/erdosreyni.html

p = k * n / (n-1); %probability than any node is connected to another
r = 1.0;

m = round(n * r, 0);
A = rand(m,m) < p;
A = triu(A,1);
A = A + A';
G = graph(A);
[bin,binsize] = conncomp(G);
idx = binsize(bin) == max(binsize);
SG = subgraph(G, idx);
current = numnodes(SG);

if abs(current-n) > (n * .05)
    connectedGraph = createConnectedGraph(n, k);
else
    SG.Edges.Weight = rand(numedges(SG), 1);
    connectedGraph = SG;
end 

end

