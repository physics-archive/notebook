function [velocityPSD] = velroot(Data,Gain,Probe,nSignals,fs) 
%creates velocity measurements for each of our 

%freqC = cfreq(Data,Gain,Probe,nSignals,fs);

psda = sqrt(PSD(Data,Gain,Probe,fs))*9.81;

freq = freqHz(Data,Gain,Probe,nSignals,fs);

velocity = psda./(sqrt(2)*2*pi*freq); %v = a/omega %PSDv(f) = -1/w^2*PSDa(f)

velocity(1:2) = 10^-8; %Need to get rid of undefined leading value. 0 Hz.

velocityPSD = velocity;
%outputs PSD(v) [m/s/sqrt(hz) rms]
%sqrt(2) RMS factor may or may not need to be included.

end




%velroot(freq, data, option):    #0 for TMC data, 1 for rms(?), any for other data(in PSD units V^2/Hz)
 %   gr = 9.81                       #defining 'g' for ease
  %  if option == 0:                 #payload data is in units of g, so need to divide by bandwidth to get back to roothz
%        bw = freq[5] - freq[4]      
  %      tmc = []
%        for i in range(len(freq)):
    %        tmc.append((gr*data[i])/(m.sqrt(bw)*2**(3/2)*m.pi*freq[i]))  #to convert from a to v, we need to 
%        return(tmc)                                                      #multiply by 9.81 (in 1 g, there are 9.81ms^-2)
%    elif option == 1:                           #and divide by omega, or 2 pi f in our case, and root2 as an rms factor
%%        v = normalize(data)                         
%        w = []
 %       for i in range(len(data)):                       #For our data, we do almost the same thing but don't divide 
 %           w.append((v[i]*gr)/(2*m.pi*freq[i]))         #by bandwidth since already in roothz units.
  %      return(w) #returns units, from normalized data, of m/s/roothz

% sqrt(dat('poff'))./(sqrt(2)*2*pi*F)