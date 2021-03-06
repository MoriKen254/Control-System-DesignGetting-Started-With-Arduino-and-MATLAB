%% pos_pid2_mbd.m

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
Kp  =  (p1*p2 + p2*p3 + p3*p1)*T/K;
Kd  = -((p1+p2+p3)*T + 1)/K;
Ki  = -p1*p2*p3*T/K;
Kff = 0;
% Kff = Ki/alpha;

%% Display PI parameters
disp('>>> PI parameters <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);
fprintf('Kd  = %f\n',Kd);
fprintf('Kff = %f\n',Kff);

%% Experiment
r      = 60;
r_cyc  = 4;
dist   = 0;
Ncyc   = 4;
tfinal = r_cyc*Ncyc;
open_system('pos_pid2_mbd_sl')
open_system('pos_pid2_mbd_sl/Scope')
%sim('pos_pid2_mbd_sl')
set_param('pos_pid2_mbd_sl', 'SimulationCommand', 'start')

%% EOF of pos_pid2_mbd.m