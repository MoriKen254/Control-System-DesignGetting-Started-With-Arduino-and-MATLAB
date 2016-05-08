%% pos_id_stepの後にこれをやる．ここからymを求め，pos_id_step_fitを行う．

%% 立ち上がり範囲をピックアップ
Start  = input('Start Time of Step(% -30からの立ち上がり始め) = '); % -30からの立ち上がり始め
End    = input('End Time of Step(30から立ち下がる直前) = '); % 30から立ち下がる直前

%t = (0:360/2-1)*ts;
%y1=y(307:486);
t = (0:(End-Start)/2-1)*ts;
y1=y(Start:End);

%% 正規化
ym = y1;
y0 = ym(1); yN = ym(end);
ym = (ym-y0)/(yN-y0);

%% 可視化
figure(1)
subplot(211)
plot(t,y1), grid
xlabel('Time [s]'),ylabel('Output [deg]')
subplot(212)
plot(t,ym), grid
xlabel('Time [s]'),ylabel('Output [deg]')