[y,Fs] = audioread('corrupted_voice.wav');
wn = [150 2200]/(Fs/2);             % Bandpass
[b, a] = butter(6,wn, 'bandpass');  % Create butter filter
f = filter(b, a, y);                % Create filter
audiowrite('clean_voice.wav',f,Fs); % Write audio
