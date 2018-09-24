function [A B_1 B_2 C D] = fullOpenLoop(G, lbuses)
%createOpenLoop create State Space representation based on graph G
%   Detailed explanation goes here
n= numnodes(G);


%% Create Values
%removed R & T because was told the effect was negligible
R = rand(1,n); %constant coefficient for the standard droop frequency control
T = rand(1,n); %time for turbine to fully respond to a change in their input.
D = .3 * rand(1, n); %positive load damping constants
M = (.3)*rand(1,n) ; %positive generator inertia constants


M(lbuses) = M(lbuses) * .001; %make M_i very small for load buses

%% Construct A
A = zeros(3*n, 3*n);

%dTheta = omega
A( 1:n ,(n+1):(2*n))= eye(n);

%dOmega = 1/M(p_m - D*omega - sigma P_ij + p^m + disturbances

A((n+1):(2*n), 1:n) = -full(weightedLaplacian(G)); %-sigma P_ij
A((n+1):(2*n),(n+1):(2*n)) = -diag(D); %-D*omega
A((n+1):(2*n),(2*n+1):(3*n)) = eye(n); %+p^m

A((n+1):(2*n), 1:3*n) = A((n+1):(2*n), 1:3*n) ./ M'; %divide everything by M

%dp^m=T^-1(-p^m - omega/R + control)
A((2*n+1):(3*n),(n+1):(2*n))= -diag(R.^-1); %omega/R

A((2*n+1):(3*n),(2*n+1):(3*n))= eye(n);

%make p^m 0 for load buses
A((2*n+1):(3*n),[lbuses, lbuses+n, lbuses+2*n]) = 0;



%% Construct B_1
%disturbance
% SLS requires Nx*Nx

B_1 = zeros(3*n, 3*n);
B_1((n+1):(2*n), (n+1):(2*n)) =  diag((M.^1)); % add  disturbances/M to dOmega


%% Construct B_2
%control

T(lbuses) = 0;
B_2 = zeros(3*n, n);
B_2((2*n+1):(3*n),1:n) =  diag((T.^1)); % add  control/T to p^m



%% Construct C
% output is omega
C = zeros(n, 3*n);
C(1:n, (n+1):(2*n)) = eye(n);

%% Construct D
%control has no effect on output

D = zeros(size(C,1),size(B_2, 2));
end

