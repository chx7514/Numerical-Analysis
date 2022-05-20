clear;
[y, fs] = audioread('DTMF_dialing.ogg');
plot(y);
y_36 = y(31850:32920);
Y_36 = abs(fft(y_36));
figure()
plot(Y_36)