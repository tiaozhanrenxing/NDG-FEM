function phys = SWESolve2d(phys)


%% Initializion of variables

h    = phys.h;  % water depth
q    = phys.q;  % water flux
dt   = phys.dt; % time step
mesh = phys.mesh;

% 5-stage Runge-Kutta coefficients
[rk4a, rk4b, rk4c] = RK45coef;
time = 0;
% Runge-Kutta residual storage  
resH = zeros(size(h));
resQ = zeros(size(q));

%% RK time stepping
while(time<FinalTime)
    % zeros Runge-Kutta residual storage
    resQ(:) = 0; resH(:) = 0;
    for INTRK = 1:5
        timeloc = time + rk4c(INTRK)*dt;
        [rhsH, rhsQ] = fluxFunc(mesh, h, q);
        
        resH = rk4a(INTRK)*resH + dt*rhsH;
        resQ = rk4a(INTRK)*resQ + dt*rhsQ;
        h = h + rk4b(INTRK)*resH;
        q = q + rk4b(INTRK)*resQ;
    end;
    % Increment time
    time = time+dt;
end

%% Assignment
phys.h = h;
phys.q = q;
end

function [rk4a, rk4b, rk4c] = RK45coef
% get Runge-Kutta coefficients
rk4a = [            0.0 ...
        -567301805773.0/1357537059087.0 ...
        -2404267990393.0/2016746695238.0 ...
        -3550918686646.0/2091501179385.0  ...
        -1275806237668.0/842570457699.0];
rk4b = [ 1432997174477.0/9575080441755.0 ...
         5161836677717.0/13612068292357.0 ...
         1720146321549.0/2090206949498.0  ...
         3134564353537.0/4481467310338.0  ...
         2277821191437.0/14882151754819.0];
rk4c = [             0.0  ...
         1432997174477.0/9575080441755.0 ...
         2526269341429.0/6820363962896.0 ...
         2006345519317.0/3224310063776.0 ...
         2802321613138.0/2924317926251.0];
end% func