%% second_sys.m

s = tf('s');
omega_n = 1;
zeta = 0.2;
P1 = omega_n^2/(s^2 + 2*zeta*omega_n*s + omega_n^2);
zeta = 1;
P2 = omega_n^2/(s^2 + 2*zeta*omega_n*s + omega_n^2);
zeta = 2;
P3 = omega_n^2/(s^2 + 2*zeta*omega_n*s + omega_n^2);

step(P1,'-',P2,'--',P3,':')
legend('zeta = 0.2','zeta = 1','zeta = 2')

%% EOF of second_sys.m