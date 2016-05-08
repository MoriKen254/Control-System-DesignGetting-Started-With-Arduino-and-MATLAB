%% velo_pi_mbd.m

%% Initialize & load data
close all
clear all
load model_data

%% PI design by pole placement
p1 = input('p1 = ');
p2 = p1; % dª‚Ìê‡
% p2 = input('p2 = '); % p2‚àw’è‚·‚éê‡

Kp = -((p1+p2)*T + 1)/K;
Ki = p1*p2*T/K;

%% Display PI parameters
disp('>>> PI parameters <<<')
fprintf('Kp  = %f\n',Kp);
fprintf('Ki  = %f\n',Ki);

%% Open simulink model
% sim
open_system('velo_pi_mbd_sl_sim');
open_system('velo_pi_mbd_sl_sim/Out1');
% real
open_system('velo_pi_mbd_sl_real');
open_system('velo_pi_mbd_sl_real/Out1');

%% Experiment-1
ts = 1/50;
sim('velo_pi_mbd_sl_sim')
set_param('velo_pi_mbd_sl_real', 'SimulationCommand', 'start')

%% EOF of velo_pi_mbd.m