%% psd_plot.m

mydata = [
6	3.085435
7	2.976334
8	2.683021
9	2.413431
10	2.222522
11	2.040635
12	1.876178
13	1.741955
14	1.610596
15	1.536139
16	1.380166
18	1.211447
20	1.107908
22	1.019492
24	0.919795
26	0.900225
28	0.710782
30	0.673470
32	0.592493
34	0.531564
36	0.492551
];
x = mydata(:,2); % Voltage  [V]
y = mydata(:,1); % Position [cm]

N = length(x);
A = [ x, y, ones(N,1) ];
Y = [ x.*y ];
% Least-squares solution
X = A\Y;

% Parameters
a  = X(1)*X(2)+X(3);
b = -X(2);
c =  X(1);
fprintf('a = %f\n',a)
fprintf('b = %f\n',b)
fprintf('c = %f\n',c)

% Fitting function
yfit = a./(x + b ) + c;

%% Plot figure
figure(1)
plot(x,y,'*',x,yfit);
xlabel('Voltage [V]')
ylabel('Distance [cm]')
legend('Measured','Calculated')
axis([0 3.5 0 40])

%% EOF of psd_plot.m