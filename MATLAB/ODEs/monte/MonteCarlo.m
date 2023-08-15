%Perform some basic (and visual) Monte Carlo Integration!
%Powerful numerical technique for integration.
    %Derived from principles of continuous probability in statistics.
    %Performs a large sum of random approximations.

f1_x = @(x) x;

%Boundaries
a=1; %Lower-bound of integral
b=100; %Upper-bound of integral
N=10000; %
M = 1.4*max(f1_x(linspace(a,b))); 
%Outputs all the y values, takes max
%Looking for above the max so we can plot above the curve. Error.


%Generate random numbers for x
x_val=rand(1,N)*(b-a) + a; %N random numbers within [a,b]
y_val=rand(1,N)*M; %

fx =f1_x(x_val);




%%Workshop code
% Perform Integral Calculation
%PercentUnderCurve = sum(y_val < fx) / N;
%Monte_Integral = PercentUnderCurve * I1_upperbound * (b-a);
%Matlab_Integral = integral(f1_x,a,b);
%PercentError = abs(Monte_Integral-Matlab_Integral)/Matlab_Integral*100;
%toc

% Plot
%plot(x,y_val','.')
%hold on
%plot(x,fx,'.')