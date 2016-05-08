%% bb_pid_hg.m

%% Initialize & load data
close all
clear all
load sim_param

%% Set identified parameters
%K = 300;
%T = 0.28;
K = 79.448969;
T =  0.103522;

%% Discrete-time plant model
P  = K/(T*s^2 + s);
Pd = c2d(P,ts,'zoh');
[numpd,denpd] = tfdata(Pd,'v');

%% PDパラメータ for 自作サーボ
omega_n_hg = 10;
zeta_hg    = 0.65;
p1 = (-zeta_hg + j*sqrt(1-zeta_hg^2))*omega_n_hg;
p2 = (-zeta_hg - j*sqrt(1-zeta_hg^2))*omega_n_hg;

%% Set PD parameters
Kp = p1*p2*T/K;
Kd = -((p1+p2)*T + 1)/K;
Ki = 0;

%% Display PID parameters
disp('>>> PID parameters for HG Servo <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);
fprintf('Kd  = %f\n',Kd);

%% サーボ 1度 あたりのアームの傾き
% 自作サーボの場合
K_theta_hg = (pi/180)*(2.1/14.1); % [rad/deg]

%% ビーム傾き角 [rad] -> ボール位置 [cm] までの 1/s^2 のゲイン
K_b = (3/5*9.8)*100;

Pb  = K_b/s^2;
Pbd = c2d(Pb,ts,'zoh');
[numbd,denbd] = tfdata(Pbd,'v');

%% PIDパラメータ for Ball位置制御
omega_n = 1.5;
zeta    = 0.6;
alpha   = 0.5;

p1 = (-zeta + j*sqrt(1-zeta^2))*omega_n;
p2 = (-zeta - j*sqrt(1-zeta^2))*omega_n;
p3 = -alpha;

kp  =  (p1*p2 + p2*p3 + p3*p1)/K_b;
ki  = -p1*p2*p3/K_b;
kd  = -(p1+p2+p3)/K_b;
% kff = 0;
kff = ki/alpha;

disp('>>> PID parameters for Ball and Beam <<<')
fprintf('kp  = %f\n',kp);
fprintf('ki  = %f\n',ki);
fprintf('kd  = %f\n',kd);
fprintf('kff = %f\n',kff);

%% Reference for ball position
r1 = 20-5;
r2 = 20+5;

%% LPFカットオフ周波数
wf = 2*pi*5;

%% LPF for ball position sensor
Fc = wf^2/(s^2+2*0.7*wf*s+wf^2);
Fd = c2d(Fc,ts,'tustin');
[numlpf,denlpf] = tfdata(Fd,'v');

%% Open simulink model
open_system('bb_pid_hg_sl');
open_system('bb_pid_hg_sl/Servo angle')
open_system('bb_pid_hg_sl/Ball position and reference')

%% EOF of bb_pid_hg.m