function [ZoomDepthOutput] = getZoomDepth(initialZoomMagnitude,numFrames)
%Inputs of numFrames and InitialZoomMagnitude

k_i = 1;
k_f = numFrames;

ZoomArray = zeros(k_i,k_f); %Num of iterations = Num of frames rendered
ZoomArray(1) = initialZoomMagnitude; %Initial magnitude of the x-and-y axes.

for k=k_i+1:k_f
    ZoomArray(k) = 0.9*ZoomArray(k-1); 
end
Zooms = length(ZoomArray);
ZoomDepthOutput = ZoomArray(Zooms); %Grabs last entry.
end