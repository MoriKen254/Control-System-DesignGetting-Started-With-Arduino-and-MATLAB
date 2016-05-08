%% velo_id_verify.m

%% Set identified parameters
% K        = 1.57;
% T        = 0.76;
% u_offset = 1.03;
K        = 0.796576
T        = 0.420000
u_offset = 0.162286

%% Open simulink model
open_system('velo_id_verify_sl');
open_system('velo_id_verify_sl/Out1');

%% Start experiment
% sim('velo_id_verify_sl')
set_param('velo_id_verify_sl', 'SimulationCommand', 'start')

%% Save Parameters
save model_data K T u_offset

%% EOF of velo_id_verify.m