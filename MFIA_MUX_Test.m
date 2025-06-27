% Parameters
fmecha = 20;                % Frequency of the sine waves (Hz)
fsampling = 27000;              % Sampling frequency (Hz)
fswitch = 1000;
t = 0:1/fsampling:5/fmecha;          % Time vector (1 second duration)

% Sine wave parameters
A1 = 0.75;                 % Amplitude of the first sine wave
A2 = 0.01;               % Amplitude of the second sine wave
offset1 = 1;           % Offset of the first sine wave
offset2 = 0;         % Offset of the second sine wave
phase_shift = pi;      % Phase shift (180 degrees)

% Generate sine waves
y1 = A1 * sin(2 * pi * fmecha * t) + offset1;  % First sine wave
y2 = A2 * sin(2 * pi * fmecha * t + phase_shift) + offset2;  % Second sine wave

% Plotting
figure;
plot(t, y1, 'b', 'DisplayName', 'Sine Wave 1');
hold on;
plot(t, y2, 'r', 'DisplayName', 'Sine Wave 2');
hold off;

% Formatting the plot
title('Sine Waves of 100 Hz');
xlabel('Time (s)');
ylabel('Amplitude');
legend show;
grid on;

% Create a new signal by multiplexing y1 and y2
num_points = fsampling/fswitch;  % Number of points to take from each signal
num_cycles = floor(length(t) / (2 * num_points));  % Number of complete cycles
new_signal = zeros(1, length(t));  % Preallocate new signal

for i = 1:num_cycles
    start_index = (i - 1) * 2 * num_points + 1;
    new_signal(start_index:start_index + num_points - 1) = y1(start_index:start_index + num_points - 1);
    new_signal(start_index + num_points:start_index + 2 * num_points - 1) = y2(start_index + num_points:start_index + 2 * num_points - 1);
end

% Plotting the new multiplexed signal
figure;
plot(t, y1, 'b--', 'DisplayName', 'Sine Wave 1');hold on;
plot(t, y2, 'r--', 'DisplayName', 'Sine Wave 2');
plot(t(1:length(new_signal)), new_signal, 'k', 'DisplayName', 'Multiplexed Signal');
hold off;

% Formatting the plot
title('Multiplexed Signal from Sine Waves');
xlabel('Time (s)');
ylabel('Amplitude');
legend show;
grid on;