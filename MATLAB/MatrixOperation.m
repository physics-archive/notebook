pi_scale = 3.14159265;
base_step = 10.^-7; %this will scale step-size of real_ and q_step

%construct a digital real number line from 0 to 1
real_step = (1 ./ pi_scale)*pi*base_step; %"irrational" number
real_initial = 0; %graph begins at at the origin
real_final = 1; %domain of [0,1]

%construct a digital rational number line from 0 to 1
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


y1=transpose(zeros(10^7,1)); %a vector with values equal to 0 for our irrationals.
y2=y1 + 1; %a vector with values equal to 1 for our rationals
verify_y=y2-y1; %should be 1 everywhere if we did this correctly. It is.

%let's actually plot y1 and y2 along our real number line from [0,1];
%this is going to render 2*10^7 points.
%plot(S1,y1,S2,y2); %two lines on top of each other, but it's 1:1 and onto
%very strange shape.

reals=[S1 S2]; %this is our real number line over [0,1]  with 20 million points.
reals_verify=length(reals) ./ length(S1); %will be 2 if we joined our rationals to our irrationals.

%I want to test that our vector was stitched together in numerical order
%being countable and ordered is an important property of R
range=10^7 -5:1:10^7 +5;
reals_middle=zeros(1,11); %define our array for memory conservation.

for k= range
    for j=1:11
        reals_middle(j)=reals(k)-reals(k+1);
    end
end %all elements should be our step size if they ordered correctly

eff=0;

alternate(3); %will return -1

X=reals;
Y=alternate_s(length(reals));
