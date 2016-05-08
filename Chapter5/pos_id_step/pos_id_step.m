%% pos_id_step.m

%% Initialize
close all
clear all
load sim_param

%% Parameters for identification
r      = 60;
r_cyc  = 8;
Kp_id  = 0.12;
Ncyc   = 8;
tfinal = r_cyc*Ncyc;

%% ID Experiment
open_system('pos_id_step_sl')
open_system('pos_id_step_sl/Scope')
%sim('pos_id_step_sl')
set_param('pos_id_step_sl', 'SimulationCommand', 'start')

%% Data processing
y = yout.signals(1).values(:,2);
t = yout.time;

NN = length(y);
%N  = r_cyc/ts;
N  = (NN-1)/Ncyc;
%yy = reshape(y(2:NN),N,(NN-1)/N);
yy = reshape(y(2:NN),N,Ncyc);
yf = yy(1:N/2,2:end); % 最初のデータを除き＆前進データのみとする

% 平均化と正規化処理
ym = mean(yf, 2);
y0 = ym(1); yN = ym(end);
ym = (ym-y0)/(yN-y0);

%% Plot figure
t = (0:N/2-1)*ts;
figure(1)
subplot(211)
plot(t,yf), grid
xlabel('Time [s]'),ylabel('Output [deg]')
subplot(212)
plot(t,ym), grid
xlabel('Time [s]'),ylabel('Output [deg]')

%% EOF of pos_id_step.m