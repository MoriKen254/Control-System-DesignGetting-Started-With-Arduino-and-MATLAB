%% pid_compare.m

%% Initialize & load data
close all
clear all
load sim_param
load model_data

%% PID design by pole placement
omega_n =  13;
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
s   = tf('s');
den = s^3 + (1+K*Kd)/T*s^2 + K*Kp/T*s + K*Ki/T;
% PID
Gyr1 = (Kd*s^2 + Kp*s + Ki)*K/T/den;

% PI-D
Gyr2 = (Kp*s + Ki)*K/T/den;

% I-PD
Gyr3 = Ki*K/T/den;

%% Step response
t=0:ts:5;
y1 = step(Gyr1,t);
y2 = step(Gyr2,t);
y3 = step(Gyr3,t);

%% Plot figure
plot(t,y1,'-',t,y2,'--',t,y3,':')
xlabel('Time [s]'), ylabel('Output')
legend('PID','PI-D','I-PD')

%% EOF of pid_compare.m