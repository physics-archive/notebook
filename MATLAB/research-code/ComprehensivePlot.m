%Experimental Parameters for Calculations
Data = 'h10sII'; %The velroot function will generate an array using this file
AmplifierGain = 10; %10 V/V setting on the P31 Amplifier
ProbeRate = 10; %On ODS Oscilloscope software - the default setting
SampleRate = 500; %5000 signals per log - variable time period
nSignals = 5000; %Fixed length of all recorded acceleration arrays

%Parameters Used to Reproduce the Sample (Paper) Data
F = transpose(linspace(0,2400,32769)); %Discreet domain over 0-2400Hz
exampleDat = 'poff'; %PSD array (column vector) to fetch from sample files
example_bandwidth = F(5) - F(4);

%PART ONE: Transform a(t) into root-PSD(v) spectra [m/s/root(hz) units]. 

velPSD = velroot(Data,AmplifierGain,ProbeRate,nSignals,SampleRate); %Narrowband
lengthVelPSD = length(velPSD); %Should be in base-2 due to the use of FFT


%PART TWO: Generate one-third octave bins by summing narrowband frequencies.

PSD_freqs = freqHz(Data,AmplifierGain,ProbeRate,nSignals,SampleRate); %base-2
bandwidth = PSD_freqs(5) - PSD_freqs(4); %Difference between any two frequencies

octaveCenter = transpose(1000./((2.^(1/3)).^(30 - [1:30]))); %Octave centers
octaveLow = octaveCenter./(2.^(1/6)); %These octave bands match those in the paper
octaveHigh = octaveCenter.*(2.^(1/6));


%PART THREE: Sort the narrowband velocities into one-third octave bands.

octRange = 1:length(octaveLow); %Looking to calculate n=30 bands, currently
kRange = 1:length(PSD_freqs); %k=4097 narrowband frequencies for 5000 signals
squaredVelocity = zeros(30,1); %Creates an empty array to fill w/ for loop
PSDv = velPSD;

for j = octRange %Adapted from the Python code associated with the paper
    for k = kRange
        if PSD_freqs(k) > octaveLow(j) && PSD_freqs(k) <= octaveHigh(j)
            squaredVelocity(j) = squaredVelocity(j) + PSDv(k)^2*bandwidth;
        end
        sortedVelocity = sqrt(squaredVelocity); %m/s-rms units
    end
end

Velocity_OneThirdOctave = sortedVelocity(1:23); %Our desired octave velocities.


%PART FOUR: Obtains sample velocities for comparison.
examplePSD = dat(exampleDat); %m/s^2/root-hz units
example_velPSD = examplePSD./(sqrt(2)*2*pi*F); %m/s/root-hz-rms units
example_squaredVelocity = zeros(30,1);
for j = octRange
    for k = kRange
        if F(k) > octaveLow(j) && F(k) <= octaveHigh(j)
            example_squaredVelocity(j) = example_squaredVelocity(j) + example_velPSD(k)^2*example_bandwidth;
        end
        example_sortedVelocity = sqrt(example_squaredVelocity); %m/s-rms units
    end
end

example_Velocity_OneThirdOctave= example_sortedVelocity(1:23);

Plot_acc
%Plot_nb
Plot