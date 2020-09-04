function [] = Exercise5(filename)
    test(filename);
    
end

function [] = plotSpect(filename)
    [y,Fs] = audioread(filename);
    L = length(y)./Fs * 1000;   % Length of signal
    T = 1/Fs;                   % Sampling period       
    t = (0:L-1)*T;              % Time vector


    nf=1024; %number of point in DTFT
    Y = fft(y,nf);
    f = Fs/2*linspace(0,1,nf/2+1);
    plot(f,abs(Y(1:nf/2+1)));
end

function [S] = removeFreq(filename)
    [y,Fs] = audioread(filename);
    Y = fftshift(fft(y));
    S = Y;
    S(1:100) = 0;
    S(end-100+2:end) = 0;
    S = fftshift(S);
    S = ifft(S);
end

