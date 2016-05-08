%% bb_lqr_servo_hg.m

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

%% LQI design
Qe = diag([10 20 20 1]);
ru = 100000;
rv = 1000;

% Error system
Abar = [A,          B   ;
        zeros(1,4), 0  ];
Bbar = [ zeros(4,1)  ;
         1          ];
Pbar = ss(Abar,Bbar,[],[]);

Q    = [ Qe,         zeros(4,1)  ;
         zeros(1,4), ru         ];
Fbar = lqr(Pbar,Q,rv);
E    = [A, B;
        C, zeros(1,1) ];
Ftmp = Fbar*inv(E);
F    = Ftmp(:,1:4);
Ki   = Ftmp(:,5);
Faug = [F, -Ki];

%% 閉ループ系の構成とステップ応答
% 拡大システム
Aaug = [ A,  zeros(4,1) ;
        -C,  0         ];
Baug = [ B  ;
         0 ];
Caug = [ C, 0 ];
Daug = [ 0 ];
Br   = [ zeros(4,1)  ;
         1          ]; % 目標値に対する入力行列

% 閉ループシステム
Paug = ss(Aaug-Baug*Faug,Br,Caug,Daug);

% ステップ応答計算
t=0:ts:5;
[y,tt,x] = step(Paug,t);

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
r1 = 20-5;
r2 = 20+5;

%% LPFカットオフ周波数
wf = 2*pi*5;

%% LPF for ball position sensor
Fc = wf^2/(s^2+2*0.7*wf*s+wf^2);
Fd = c2d(Fc,ts,'tustin');
[numlpf,denlpf] = tfdata(Fd,'v');

%% Open simulink model
open_system('bb_lqr_servo_hg_sl');
open_system('bb_lqr_servo_hg_sl/Ball position and motor angle')

%% EOF of bb_lqr_servo_hg.m