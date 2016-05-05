%% led_blink2.m
a = arduino('COM3');
for i=1:10
    for dutyCycle=0:0.01:1
        writePWMDutyCycle(a, 'D11', dutyCycle);
    end
    for dutyCycle=1:-0.01:0
        writePWMDutyCycle(a, 'D11', dutyCycle);
    end
end
clear a;