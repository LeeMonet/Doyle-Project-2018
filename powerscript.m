%% input

Nx = 20;%number of nodes
p = .2; %connectedness of graph 0>p>=1
a = .2; %percent of nodes that load buses
tau = .01;


%% Set Up
%Create Graph, continuous SS matrices, and discretize

lbuses = [];%randomly choose which are load buses 

G = createConnectedGraph(Nx, p);
[A_c, B1, B2_c, C, D] = fullOpenLoop(G, lbuses); 
[A, B_2]= discretizeMatrices(A_c, B2_c, tau);


%% Solve for optimal system response (R,M) with H2 (squared) objective
% d-localized means d-hop locality constraints on (R,M)
% comm-speed needs to be sufficiently large.  ta is actuation delay

%FIR horizon   
T = 50;
Tmax = 25;
Tsim = T + Tmax;

d = 10;
comms = 2;
ta = 1;

[R1,M1]  = sf_sls_d_localized(A,B_2,C,D,T,d,comms,ta,'H2');



