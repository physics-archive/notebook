%MATLAB handles arrays very eficiently. We can sum from n=1 to n=1M to
%demonstrate that our sum is converging.

%Define our index n from 1 to 1 million. That is, we sum one million terms
%of 1/n^2.

n0=1; %starting value for our index. we've been using n=1 to start
N=10^6; %maximum value of n. determines the accuracy/preiciosn of our ans
n = n0:N; %creates a 1-dimensional vector (list) of our index n.
number_of_additions=length(n); %how many terms there are. total number of n

S(n0:N)=1 ./ (n .^2); %Vectorized expression for our sequence
                      %As a vector, Dim[S]=1.

n_equalto_4=S(4); %Return S(n=4)=1/16 to test that this vector works

converges_to=sum(S); %Sum of all elements in our "vector" S(n)

analytical=pi^2 ./ 6; %this is the analytically-obtained sum.

error=analytical-converges_to;