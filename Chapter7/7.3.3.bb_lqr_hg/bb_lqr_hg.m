%% bb_lqr_hg.m

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

%% ビーム傾き角 [rad] -> ボール位置 [cm] までの 1/s^2 のゲイン
K_b = (3/5*9.8)*100;

Pb  = K_b/s^2;
Pbd = c2d(Pb,ts,'zoh');
[numbd,denbd] = tfdata(Pbd,'v');

%% サーボ 1度 あたりのアームの傾き
% 自作サーボの場合
K_theta_hg = (pi/180)*(2.1/15); % [rad/deg]

%% 状態方程式
A = [0  1  0               0    ;
     0  0  K_b*K_theta_hg  0    ;
     0  0  0               1    ;
     0  0  0              -1/T ];
B = [ 0    ;
      0    ;
      0    ;
      K/T ];
C = [ 1  0  0  0 ];
D = 0;
Pbb = ss(A,B,C,D);

%% LQ design
Q = diag([500 20 20 1]);
R = 10000;
F = lqr(Pbb,Q,R)

%% Simulation
t  = 0:ts:5;
x0 = [10,0,0,0]';

Pcl = ss(A-B*F,zeros(4,1),C,D);
[y,tt,x] = initial(Pcl,x0,t);

%% Plot figure
figure(1)
subplot(211)
plot(t,x(:,1:2))
xlabel('Time [s]'), ylabel('Ball position and velocity')
legend('x','d/dt x')
subplot(212)
plot(t,x(:,3:4))
xlabel('Time [s]'), ylabel('Servo angle and angular velocity')
legend('\phi','d/dt \phi')

%% Reference for ball position
r1 = 20;
r2 = 20;

%% LPFカットオフ周波数
wf = 2*pi*5;

%% LPF for ball position sensor
Fc = wf^2/(s^2+2*0.7*wf*s+wf^2);
Fd = c2d(Fc,ts,'tustin');
[numlpf,denlpf] = tfdata(Fd,'v');

%% Open simulink model
open_system('bb_lqr_hg_sl');
open_system('bb_lqr_hg_sl/Ball position and motor angle')

%% EOF of bb_lqr_hg.m