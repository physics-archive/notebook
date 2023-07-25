function [Energy] = Energy(R,Density,time)
%ENERGY Summary of this function goes here
%   Detailed explanation goes here


Energy = R.^5 .* Density ./ time.^2;

end

