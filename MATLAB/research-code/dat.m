function [Dat] = dat(Data) %Function which references the filename, assuming .xls format
format long e
DatFile = strcat(Data,'.xlsx'); %Concatenates the filename with .xls extension

DataMatrix = readmatrix(DatFile); %Creates a matrix out of the .xls data file

bat = DataMatrix(:,2); %Reads the voltage measurements from the .xls file
Dat = sqrt(bat)*9.81;
%plot(Hz('poff'),dat('poff'))
%vdat = sqrt(dat('LABPLATEON'))./(sqrt(2)*2*pi*F)
%octSortDat(ans,F)
%plot(cfreq('m10s',10,10,5000,500),ans)