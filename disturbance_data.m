function [MATx, MATu] = disturbance_data(A, B, B1,T, R, M, dist, Tmax);
%janie_heat_map heat map representing multiple multitime step disturbances
%   dist location of disturbances, start time, duration


open_loop = 0;

Nx = size(A, 1);
Nu = size(B,2);

Tstart = T+1;

%create disturbance matrix
location = dist(:,1);
duration = dist(:, 3);
start = dist(:, 2);



w_d = zeros(Nx,Tmax);
loop = length(location);
for i = 1:loop
    stop = start(i) + duration(i);
    loc = location(i);
    if stop < Tmax 
        interval = (T + start(i)):(T + stop);
        w_d(loc, interval)= 1;
    end
end




x=zeros(Nx,Tmax);
u=zeros(Nu,Tmax);
x_ref=zeros(Nx,Tmax);
w_est=zeros(Nx,Tmax);


MATx = [];
MATu = [];
for i=Tstart:1:Tmax-1

    w_est(:,i-1) = x(:,i) - x_ref(:,i); %estimated disturbance
    
    %calculate control action for time i
    for jj=1:1:T
        if (open_loop==1)
           u(:,i) = zeros(Nu,1);
        else
           u(:,i) = u(:,i) + M{jj}*w_est(:,i-jj);
        end
    end
    
    %calculate state i+1 with control and real disturbance
    x(:,i+1) = A*x(:,i) + B1*w_d(:,i)+ B*u(:,i);
    
    %calculate x reference
    for jj=2:1:T
        if (open_loop==1)
           x_ref(:,i+1) = x_ref(:,i+1); 
        else
           x_ref(:,i+1) = x_ref(:,i+1) + R{jj}*w_est(:,i+1-jj);
        end
    end
    

    MATx = [MATx,x(:,i)]; %add state at time i to matrix
    MATu = [MATu, B*u(:,i)]; %add control action at time i to matrix
    
end


end