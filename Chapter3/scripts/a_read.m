%% a_read.m
a = arduino('COM3');
voltage = readVoltage(a, 'A0');
fprintf('\nstart!\n');
tic
while (toc < 10)
    voltage = readVoltage(a, 'A0');%*(5/1023); % 5V‚ÉŠ·ŽZ
    fprintf('voltage = %f\n', voltage);
    pause(0.5);
end
clear a;
