
%function F = movieSample(Nx)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


%% f
%FIR horizon
T = 20;
Tmax = 25;
Tsim = T + Tmax;
Nx=15;

%create Graph
Adj = speye(Nx);
Adj = [zeros(Nx,1), Adj];
Adj = Adj(:,1:Nx);
G = graph(Adj, "upper");

%% stugg

% Generate state space parameters
[A,B] = generate_dbl_stoch_chain(Nx,.2,1,1);

%number actuators
Nu = size(B,2);

% Specify objective function parameters
C = [speye(Nx); sparse(Nu,Nx)];
D = [sparse(Nx,Nu); speye(Nu)];

%generate controllers
d = 5;
comms = 2;
ta = 1;

[R1,M1]  = sf_sls_d_localized(A,B,C,D,Tsim,d,comms,ta,'H2');


% dist = [floor(Nx/3), 1, 6;
%         floor(Nx/2), 6, 3;
%         floor(2*Nx/3), 10, 3];

dist = [floor(Nx/2), 1, 1];

[MATx, MATu] = multi_disturbance_data(A,B,T,Nx,Nu,R1,M1,dist,Tsim,'Localized');

%% more
sz = mat2Size(MATx, -4);
rgb = mat2RGB(MATx, -4);

F = createMovie(rgb, sz, G);

% end

