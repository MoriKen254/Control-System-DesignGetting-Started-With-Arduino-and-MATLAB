%% sim_init.m

%% Initialize
close all
clear all

%% Common parameters
ts = 1/50;
s  = tf('s');

%% PID gain
Kp = 0;
Ki = 0;
Kd = 0;

%% Reference parameters
r      = 60;
r_cyc  = 4;
dist   = 0;
Ncyc   = 2;
tfinal = r_cyc*Ncyc;

%% Save data
save sim_param

%% EOF of sim_init.m