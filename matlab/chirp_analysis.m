% Combine real and imaginary vectors/matrices into a complex signal
real = out.real.Data;
img = out.Img.Data;

complex_signal = real + 1i * img;

% Slice the signal to keep only the first 2500 samples
complex_signal = complex_signal(1:2500);

% 1. Define your system configuration
Fs = 245.76e6;           

% 2. OPTIMIZED SPECTRUGRAM PARAMETERS FOR CRISP LINE
% Shorter window gives fine time slices; high overlap smooths out the line
window_size = 512;        % Decrease for sharpen time resolution
overlap     = 450;        % High overlap (~93%) for smooth horizontal transitions
nfft        = 512;       % Increase for a highly detailed frequency grid

[S, F, T] = spectrogram(complex_signal, window_size, overlap, nfft, Fs, 'centered');

% 3. Convert magnitude to decibels (dB) for better contrast
S_dB = 10 * log10(abs(S).^2);

% 4. Plot Time on X-axis and Frequency on Y-axis
figure;
imagesc(T, F, S_dB);  
axis xy;              
ylim([-20e6, 20e6]);  % Your specified frequency zoom

colormap('jet');      
colorbar;             

% 5. Format labels and titles
xlabel('Time (seconds)');
ylabel('Frequency (Hz)');
title('Time-Frequency Spectrogram (High Resolution)');
