%% sw_count.m
a = arduino('COM3');
c = 0; % counter
s = 0; % state
fprintf('start!\n');
while (c < 10)
    din = readDigitalPin(a, 'D12');
    if (din == 0 && s == 0)
        c = c + 1;
        fprintf('c = %d\n', c);
        s = 1;
    end
    if (din == 1 && s == 1)
        s = 0;
    end
end
clear a;
