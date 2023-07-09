function [freqs] = freqHz(Data,Gain,Probe,nSignals,fs)
format long e

[pxx,f] = periodogram(acc(Data,Gain,Probe),0:nSignals-1,[],fs,'power');

freq = [pxx, f];

freqs = freq(:,2);

end