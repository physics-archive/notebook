%%SCRIPT TO BE EXECUTED FOR COMPUTATION AND PLOTTING OF THE FRACTAL

%%Define and establish the Newton-Raphson iteration:
%%We want to discover roots (z) of some polynomial (f), for any order (Np)

%%Acquire a polynomial function and its derivative
func = @(Z) Z.^3-1;
dfunc = @(Z) 3*Z.^2;

%Obtain the roots of func (func(root) = 0)
%reRoots = fzero(func,0,); Replaced by roots
%syms v
%V = coeffs(func(v),v,'All');
Roots = roots([1 0 0 -1]);

Nx = 2000;
Ny = 2000;

scope = 3;

xmin = -scope; xmax = scope;
ymin = -scope; ymax = scope;

Y = linspace(xmin,xmax,Nx);
X = linspace(ymin,ymax,Ny);

[Xmesh,Ymesh] = meshgrid(X,Y);
Z = Xmesh+1i*Ymesh;

%%Iterate Newton-Raphson algorithm 40 times
NumIterations = 30;
for Iteration=1:NumIterations
    Z = Z - func(Z) ./ dfunc(Z);
end

%%Map convergent points on a color grid
Err=0.001;
Z1=abs(Z-Roots(1)) < Err;
Z2=abs(Z-Roots(2)) < Err;
Z3=abs(Z-Roots(3)) < Err;
Z4=~(Z1+Z2+Z3);

%%DEBUG AREA
%output Z
Z1_Debug = Z(1);
ActualRoot1 = Roots(1);
ActualRoot2 = Roots(2);
ActualRoot3 = Roots(3);
%%END OF DEBUF VALUES
figure;
map = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 0 0];
colormap(map); %[red;blue;green;yellow;black]
Z=(Z1+2*Z2+3*Z3+4*Z4);
image([xmin xmax], [ymin ymax], Z); set(gca,'YDir','normal');
xlabel('$x$', 'Interpreter', 'latex', 'FontSize',14);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize',14);
title('Fractal from $f(z)$', 'Interpreter', 'latex','FontSize', 16);