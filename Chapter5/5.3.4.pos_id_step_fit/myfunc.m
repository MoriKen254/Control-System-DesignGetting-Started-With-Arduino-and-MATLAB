function J = myfunc(x,y,t,ts,Kp_id);
% x     = [K,T]'
% y     = step response data obtained by experiment
% t     = time vector
% ts    = sampling time
% Kp_id = feedback gain for identification

K    = x(1);
T    = x(2);
P    = tf([0 0 K],[T 1 0]); % P = K/(Ts^2 + s);
Pd   = c2d(P,ts,'zoh');     % Discretization
Ld   = Pd*Kp_id;            % Loop transfer function
Gd   = feedback(Ld,1);      % Closed-loop system
ysim = step(Gd,t);          % Step response
J    = norm(y-ysim,2);      % Error

%% EOF of myfunc.m