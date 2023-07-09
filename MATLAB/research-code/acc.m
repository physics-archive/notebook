function [Acc] = acc(Data,Gain,Probe) %Function which references the filename, assuming .xls format
format long e
DatFile = strcat(Data,'.xls'); %Concatenates the filename with .xls extension

DataMatrix = readmatrix(DatFile); %Creates a matrix out of the .xls data file

%Acc = DataMatrix(:,3)./(10*Gain*Probe./9.81); %Reads the voltage measurements from the .xls file
Acc = DataMatrix(:,3);