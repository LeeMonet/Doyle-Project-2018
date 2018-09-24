function [A B_1 B_2 C] = simpleOpenLoop(G, lbuses)
%createOpenLoop create State Space representation based on graph G
%   Detailed explanation goes here
n= numnodes(G);


%% Create Values
%removed R & T because was told the effect was negligible
D = .3 * rand(1, n); %positive load damping constants
M = (.3)*rand(1,n) ; %positive generator inertia constants

M(lbuses) = M(lbuses) * .001; %make M_i very small for load buses

%% Construct A
A = zeros(2*n, 2*n);

%dTheta = omega
A( 1:n ,(n+1):(2*n))= eye(n);

%dOmega = 1/M(p_m - D*omega - sigma P_ij + disturbances

A((n+1):(2*n), 1:n) = -full(weightedLaplacian(G)); %-sigma P_ij
A((n+1):(2*n),(n+1):(2*n)) = -diag(D); %-D*omega

A((n+1):(2*n), 1:2*n) = A((n+1):(2*n), 1:2*n) ./ M'; %diviide everything by M

%% Construct B_1

B_1 = zeros(2*n, 2*n);
B_1((n+1):(2*n), 1:n) =  diag((M.^1)); % add  disturbances/M to dOmega
B_1((n+1):(2*n), (n+1):(2*n)) =  diag((M.^1));
%% Construct B_2
%control
B_2 = zeros(2*n, 1);
B_2((n+1):(2*n), 1:n) =  diag((M.^1)); % add  control/M to dOmega


%% Construct C
% output is omega
C = zeros(2*n, 1);
C((n+1):(2*n), 1:n) = eye(n);


end

