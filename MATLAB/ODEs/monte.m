function mIntegrate(a,b,N)

b = 1;
a=0;
h = 1/N;
  for i = a : N b
         x = (b-a).*rand(1,1000) + a; %%size N uniform random numbers
         mu_x = mean(x); %%just for error interest
         
         %%factor = (b-a)*1/N; Legacy code
        
        y(i) = sin(x)
     

  end
  

