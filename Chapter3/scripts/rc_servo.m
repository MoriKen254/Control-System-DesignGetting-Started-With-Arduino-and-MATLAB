%% rc_servo.m
a = arduino('COM3');
s = servo(a, 'D10');
fprintf('start!\n');

writePosition(s, 0.5); % ranga; 0~1
disp('90')
pause(2);

for i=0:5
    writePosition(s, 0.5+0.25);
    disp('90+45')
    pause(1);
    writePosition(s, 0.5-0.25);
    disp('90-45')
    pause(1);
end
writePosition(s, 0.5);
disp('90')
pause(2);

clear s;
clear a;
