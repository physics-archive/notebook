pi_scale = 3.14159265;
base_step = 10.^-7; %this will scale step-size of real_ and q_step

real_step = (1 ./ pi_scale)*pi*base_step; %"irrational" number
real_initial = 0; %graph begins at at the origin
real_final = 1; %domain of [0,1]

q_step = base_step;
q_initial = 0;
q_final = 1;

S_irrational = real_initial:real_step:real_final; 
    S1=S_irrational(1:1/(base_step));
    lengthS_irrational=length(S_irrational); %dimension number of our set
%With S1 we are vectorizing our sets so that their dimensions match.
%Requirement for scalar multiplication of two vectors.

S_rational = q_initial:q_step:q_final; S2=S_rational(1:(1/base_step));
    lengthS_rational=length(S_rational); %dimension number of our set
%linespace alternatively - can explore difference

%Some cool values:

%The difference between our rational and "irrational" numbers:
%Should be '1' (true) for all nonzero elements, and false for else.
Difference = S1-S2 == 0;
true_false_difference=Difference(1:10000);
Nine_millionth_element=Difference(9*10^6); %returns 0. These sets never equal.





plot(S1);