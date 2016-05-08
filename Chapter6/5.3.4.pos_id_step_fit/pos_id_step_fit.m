%% pos_id_step_fit.m

%% Parameter identification
Lt    = input('Time length for fitting = ');
L     = Lt/ts;
y_fit = ym(1:L);
t_fit = (0:L-1)*ts;
%x0    = [500,0.5];
x0    = [50,0.5];

% Search parameters
xmin  = fminsearch(@(x) myfunc(x,y_fit,t_fit,ts,Kp_id),x0);

%% Plot figure
K_id = xmin(1);
T_id = xmin(2);
P  = tf([0 0 K_id],[T_id 1 0]);
Pd = c2d(P,ts,'zoh');
Ld = Pd*Kp_id;
Gd = feedback(Ld,1);
ymodel = step(Gd,t);
figure(2)
plot(t,ym,'b-',t_fit,y_fit,'b*',t,ymodel,'r-');
xlabel('Time [s]'), ylabel('Output [deg]')

%% Display results
fprintf('== Results ==\n')
fprintf('K = %f\n',K_id)
fprintf('T = %f\n',T_id)

%% EOF of pos_id_step_fit.m