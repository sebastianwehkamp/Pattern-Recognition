[y,Fs] = audioread('corrupted_voice.wav');
Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);                  %Prepare time data for plotES
%Do Fourier Transform
yFT = fft(y);
% %Prepare plot FT
y_fft = abs(yFT);                       %Retain Magnitude
y_fft = y_fft(1:floor(Nsamps/2));       %Discard Half of Points
f = Fs*(0:Nsamps/2-1)/Nsamps;           %Prepare freq data for plot
%Plot Sound File in Frequency Domain
figure
plot(f, y_fft)
xlabel('Frequency (Hz)')
ylabel('Amplitude')