%% bb_lqr_test.m

%% Initialize & load data
close all
clear all
load sim_param

%% Set identified parameters
%K = 300;
%T = 0.28;
K = 79.448969;
T =  0.103522;

%% ビーム傾き角 [rad] -> ボール位置 [cm] までの 1/s^2 のゲイン
K_b = (3/5*9.8)*100;

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

%% LQ design 1
Q1 = diag([100 20 20 1]);
R1 = 10000;
F1 = lqr(Pbb,Q1,R1);

%% LQ design 2
Q2 = diag([500 20 20 1]);
R2 = 10000;
F2 = lqr(Pbb,Q2,R2);

%% Simulation
t  = 0:ts:5;
x0 = [10,0,0,0]'; % Set initial state

% Closed-loop system
Pcl1 = ss(A-B*F1,zeros(4,1),C,D);
Pcl2 = ss(A-B*F2,zeros(4,1),C,D);

% Initial state response
[y1,tt1,X1] = initial(Pcl1,x0,t);
[y2,tt2,X2] = initial(Pcl2,x0,t);

%% Plot figure
figure(1)
subplot(211)
plot(t,X1(:,1:2),t,X2(:,1:2),'--')
xlabel('Time [s]'), ylabel('Ball position and velocity')
legend('Design 1 x','Design 1 d/dt x','Design 2 x','Design 2 d/dt x')
subplot(212)
plot(t,X1(:,3:4),t,X2(:,3:4),'--')
xlabel('Time [s]'), ylabel('Servo angle and angular velocity')
legend('Design 1 \phi','Design 1 d/dt \phi','Design 2 \phi','Design 2 d/dt \phi')

%% EOF of bb_lqr_test.m