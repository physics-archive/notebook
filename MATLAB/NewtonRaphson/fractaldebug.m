set(groot, 'defaultFigureCloseRequestFcn', 'close(gcf)');
%%SCRIPT TO BE EXECUTED FOR COMPUTATION AND PLOTTING OF THE FRACTAL

%%Define and establish the Newton-Raphson iteration:
%%We want to discover roots (z) of some polynomial (f), for any order (Np)

%Adjustment = [0 -0.35];
Adjustment = [0 0];
%Adjustment = 0.1*pi;
%Adjustment = 0;

%%Acquire a polynomial function and its derivative
func = @(Z) (Z+Adjustment(1)).^3-1+Adjustment(2);
dfunc = @(Z) 3*(Adjustment(1)-Z).^2;

%Obtain the roots of func (func(root) = 0)
%reRoots = fzero(func,0,); Replaced by roots
%syms v
%V = coeffs(func(v),v,'All');
Roots = roots([1+Adjustment(1) 0 0 -1+Adjustment(2)]);

Nx = 1200;
Ny = 1200;

%ITERATE EXPORT_FIG
%NEED LOGARITHMIC ZOOMING. 5 OR 10%.
for scope = 0.001:0.001:2 
    index = 1000*scope;
    
    xmin = -scope; xmax = -xmin;
    ymin = -scope; ymax = -ymin;
    
    Y = linspace(xmin,xmax,Nx)-0.35;
    X = linspace(ymin,ymax,Ny);
    
    [Xmesh,Ymesh] = meshgrid(X,Y);
    Z = Xmesh+1i*Ymesh;
    
    %%Iterate Newton-Raphson algorithm 40 times
    %Optimize with dynamic iteration size!
    NumIterations = 40; 
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
    %%END OF DEBUG VALUES

    figure;
    map = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 0 0];
    colormap(map); %[red;blue;green;yellow;black]
    Z=(Z1+2*Z2+3*Z3+4*Z4);
    image([xmin xmax], [ymin ymax], Z); set(gca,'YDir','normal');
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize',14);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize',14);
    title('Fractal from $f(z)$', 'Interpreter', 'latex','FontSize', 16);
    
    export_fig(strcat(['/Users/s285/Downloads/NewtonZoom/ZoomDebug','-frame-',num2str(index)]), '-png', '-r200');
    
    clf;
    close all;
end