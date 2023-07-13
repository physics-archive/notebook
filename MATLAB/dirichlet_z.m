MatrixOperation

Yz = zeros(1,length(Y)); %refreshes out outputs so we can use Z

Xz=X*10^2; %scales up so we have some integers to work with on our plot
V = Xz;
R = find(Xz==int32(Xz)); %debug to look for integers

l = isnumeric(V)&rem(V,1)==0; %sifts for integers

ii  = find(l,1,'first'); % 2
ValInt = V(ii); % 1 and 3

Yzf = Yz + l;

plot(Xz,Yzf,".")
axis([0 50 -1.5 1.5]);