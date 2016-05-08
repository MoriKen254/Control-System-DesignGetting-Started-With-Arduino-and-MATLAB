%% pos_tdof_mbd.m

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

%% TDOF reference model design
m_omega_n = 6;
m_zeta    = 0.7;

% Reference model
Mc = m_omega_n^2/(s^2 + 2*m_zeta*m_omega_n*s + m_omega_n^2);
% Feedforward controller
P   = K/(T*s^2 + s);
Gfc = Mc/P;
% Discretization
Md = c2d(Mc,ts,'zoh');
[nummd,denmd] = tfdata(Md,'v');
Gfd = c2d(Gfc,ts,'zoh');
[numgfd,dengfd] = tfdata(Gfd,'v');

%% Set PID parameters
Kp  =  (p1*p2 + p2*p3 + p3*p1)*T/K;
Kd  = -((p1+p2+p3)*T + 1)/K;
Ki  = -p1*p2*p3*T/K;

%% Display PI parameters
disp('>>> PI parameters <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);
fprintf('Kd  = %f\n',Kd);

%% Experiment
r      = 60;
r_cyc  = 4;
dist   = 1; % ’èíŠO—‚ğ“ü‚ê‚Ä‚à‘åä•v
Ncyc   = 4;
tfinal = r_cyc*Ncyc;
open_system('pos_tdof_mbd_sl')
open_system('pos_tdof_mbd_sl/Scope')
% sim('pos_tdof_mbd_sl')
set_param('pos_tdof_mbd_sl', 'SimulationCommand', 'start')

%% EOF of pos_tdof_mbd.m