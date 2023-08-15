function [v1] = montef(a,b,N)

h = 1/N;

x = (b-a).*rand(1,1000); + a; %%size N uniform random numbers
mu_x = mean(x); %%just for error interest
%(mu_x);
  for i = 1 : N
         
         
        
    y(i)=sin(x(i));
    
    v1=y;
  end
