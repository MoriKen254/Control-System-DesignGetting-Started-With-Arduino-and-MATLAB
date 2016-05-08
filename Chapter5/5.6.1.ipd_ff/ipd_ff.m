%% ipd_ff.m

%% Initialize & load data
close all
clear all
load sim_param
load model_data

%% PID design by pole placement
omega_n =  12;
zeta    =  0.6;
alpha   =  2;

p1 = (-zeta + j*sqrt(1-zeta^2))*omega_n;
p2 = (-zeta - j*sqrt(1-zeta^2))*omega_n;
p3 = -alpha;

%% Set PID parameters
Kp =  (p1*p2 + p2*p3 + p3*p1)*T/K;
Kd = -((p1+p2+p3)*T + 1)/K;
Ki = -p1*p2*p3*T/K;

%% Display PI parameters
disp('>>> PI parameters <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);
fprintf('Kd  = %f\n',Kd);

%% Closed-loop transfer function
% Common
den = s^3 + (1+K*Kd)/T*s^2 + K*Kp/T*s + K*Ki/T;
% I-PD
Kff = 0;
Gyr1 = (Kff*s+Ki)*K/T/den;

% I-PD + Kff
Kff = Ki/alpha;
Gyr2 = (Kff*s+Ki)*K/T/den;

%% Step response
t=0:ts:5;
y1 = step(Gyr1,t);
y2 = step(Gyr2,t);

%% Plot figure
plot(t,y1,'-',t,y2,'--')
xlabel('Time [s]'), ylabel('Output')
legend('I-PD','I-PD+FF');

%% EOF of ipd_ff.m