function [PSD] = PSD(Data, Gain, ProbeRate, fs) %Function which references the filename, assuming .xls format
format long e

%DatFile = strcat(Data,'.xls'); %Concatenates the filename with .xls extension

%DataMatrix = readmatrix(DatFile); %Creates a matrix out of the .xls data file

%Acc_from_Voltage = DataMatrix(:,3)./(10*Gain*ProbeRate./9.81); %[m/s^2]
                                                %Converts the voltage measurements from the .xls file
                                                %Gain = Amp. gain (V/g),
                                                %ProbeRate = 10x typically
                                                %1000 for mV conversion
                                                
%f = length(RawVoltage); %obs

%fs = 5000 / T; %Sampling rate (Hz) for T (s), obs


psd = periodogram(acc(Data,Gain,ProbeRate),[],[],fs); 
psdg = psd./(10*Gain*ProbeRate*1000)^2; %Gives the PSD of our voltage measurements (acc^2/Hz)
PSD = psdg;
end
%Produces a PSD with N = 2^13 + 1 points.


%Useful Code ---

%poctave(acc('m10s',10,10),500,'FrequencyLimits',[4.5:250],'BandsPerOctave',3)
%poctave(PSD('d10s',10,10,500),500,freqHz('d10s',10,10,5000,500),'BandsPerOctave',3,'psd')
