%% pos_id_step�̌�ɂ�������D��������ym�����߁Cpos_id_step_fit���s���D

%% �����オ��͈͂��s�b�N�A�b�v
Start  = input('Start Time of Step(% -30����̗����オ��n��) = '); % -30����̗����オ��n��
End    = input('End Time of Step(30���痧�������钼�O) = '); % 30���痧�������钼�O

%t = (0:360/2-1)*ts;
%y1=y(307:486);
t = (0:(End-Start)/2-1)*ts;
y1=y(Start:End);

%% ���K��
ym = y1;
y0 = ym(1); yN = ym(end);
ym = (ym-y0)/(yN-y0);

%% ����
figure(1)
subplot(211)
plot(t,y1), grid
xlabel('Time [s]'),ylabel('Output [deg]')
subplot(212)
plot(t,ym), grid
xlabel('Time [s]'),ylabel('Output [deg]')