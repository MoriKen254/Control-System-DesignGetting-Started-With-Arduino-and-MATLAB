%% pos_pid_set.m

%% Initialize
close all
clear all
load sim_param
load model_data

%% Set PID parameters
Kp     = 0.12;
Ki     = 0;
Kd     = 0.0095;

%% Display PID parameters
disp('>>> PID parameters <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);
fprintf('Kd  = %f\n',Kd);

%% Experiment
r      = 60;
r_cyc  = 4;
dist   = 0;
Ncyc   = 4;
tfinal = r_cyc*Ncyc;
open_system('pos_pid_mbd_sl')
open_system('pos_pid_mbd_sl/Scope')
% sim('pos_pid_mbd_sl')
set_param('pos_pid_mbd_sl', 'SimulationCommand', 'start')

%% EOF of pos_pid_set.m