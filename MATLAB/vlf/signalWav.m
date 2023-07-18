%[y,Fs] = audioread(filename) reads data from the file named filename, 
% and returns sampled data, y, and a sample rate for that data, Fs.

%example
%[y,Fs] = audioread(filename,samples) reads the selected range of 
% audio samples in the file, where samples is a vector of the form [start,finish].

%example
%[y,Fs] = audioread(___,dataType) returns sampled data in the data 
% range corresponding to the dataType of 'native' or 'double'

%plot( 1:length(y) ,y);

%fftt=fft(y,2^15,1);

%plot(1:length(fftt),fftt);
%sum(y);

[AudioMagnitude,SampleRate]=audioread("/Users/s285/Desktop/Archives/PROJ/7-15-0041020-vlf35.wav");

%sound(y,Fs,24);

plot(AudioMagnitude);

plot(linspace(0,50,length(periodogram(AudioMagnitude))),periodogram(AudioMagnitude));