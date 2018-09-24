function [MATx, MATu] = make_disturbance_data(A,B,T,Nx,Nu,R,M,loc,Tmax)


open_loop = 0;



Tstart = T+1;

B1 = eye(Nx); %map disturbance to state

w_d = zeros(Nx,Tmax);
w_d(loc,Tstart) = 10;
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
    

    MATx = [MATx,log10(abs(x(:,i)))]; %add state at time i to matrix
    MATu = [MATu,log10(abs(B*u(:,i)))]; %add control action at time i to matrix
    
end



end