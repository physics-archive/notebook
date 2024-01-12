set(groot, 'defaultFigureCloseRequestFcn', 'close(gcf)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  LEGACY CODE                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Adjustment = 0.1*pi;
%Adjustment = 0;
%Adjustment = [0 -0.35];

Adjustment = [0 0]; %Does not adjust polynomial. 
                    %Canned method for shifting root locations.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                VARIABLE INPUTS                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
initialZoomMagnitude = 5;
numFramesToRender = 10;
%finalZoomValue = 1.4;

DebugDepth=getZoomDepth(initialZoomMagnitude,numFramesToRender); %debug
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               DEFINE POLYNOMIAL               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Specify a polynomial f(z) and its derivative df(z)
%Iterated in the computational engine for root finding
func = @(Z) (Z+Adjustment(1)).^3-1+Adjustment(2);
dfunc = @(Z) 3*(Adjustment(1)-Z).^2;

%Find the roots to f(z). 
%Roots(Az^4 + az^3 + bz^2 + cz + d = 0)
Roots = roots([1+Adjustment(1) 0 0 -1+Adjustment(2)]);

Nx = 2000;
Ny = 2000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  ZOOM ENGINE                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Index Initial:StepSize:Final. 
k_i = 1;
k_f = numFramesToRender;

%Pre-allocate an empty array of length(k_f) to fill w/ zoom boundaries.
ZoomArray = zeros(k_i,k_f); %Num of iterations = Num of frames rendered
ZoomArray(1) = initialZoomMagnitude; %Initial magnitude of the x-and-y axes.

%Generate zoom values in array. Skip lead entry. k =/= 0.
for k=k_i+1:k_f
    ZoomArray(k) = 0.9*ZoomArray(k-1); 
end
EngineIterationIndex=ZoomArray;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             COMPUTATIONAL ENGINE              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This engine iterates the Newton-Raphson len(k_array) times.
%If a z value converges within Err bounds of a complex root,
%Then the colormap will indicate which root. Results in a fractal!

%k_array = flip(0.1:0.1:1); %flip array to zoom inwards
%for scope = 0.01:0.01:0.1
for scope = EngineIterationIndex
    index = 1000*scope; %For Filename purposes only.
    
    xmin = -scope; xmax = -xmin;
    ymin = -scope; ymax = -ymin;
    
    Y = linspace(xmin,xmax,Nx);
    X = linspace(ymin,ymax,Ny);
    
    %Y_Adjusted = linspace(xmin,xmax,Nx)-0.35;
    %X_Adjusted = linspace(ymin,ymax,Ny);
    
    [Xmesh,Ymesh] = meshgrid(X,Y);
    Z = Xmesh+1i*Ymesh;
    
    %Optimize with dynamic iteration size!
    %TIME-CONSUMING TASK OF THIS SCRIPT
    NumIterations = 35; 
    for Iteration=1:NumIterations
        Z = Z - func(Z) ./ dfunc(Z); 
    end
    
    %Map convergent points on a color grid
    %Convergence tolerance equal to Err=0.001. No convergence -> black map
    Err=0.001;
    Z1=abs(Z-Roots(1)) < Err;
    Z2=abs(Z-Roots(2)) < Err;
    Z3=abs(Z-Roots(3)) < Err;
    Z4=~(Z1+Z2+Z3); %Z4=0 if arg in ~(arg) is zero

    figure;
    ColormapScheme = [1 0 0; 0 1 0; 0 0 1; 0 0 0; 1 1 0];
    colormap(ColormapScheme); %[red;blue;green;black;yellow]
    Z=(Z1+2*Z2+3*Z3+4*Z4);
    image([xmin xmax], [ymin ymax], Z); set(gca,'YDir','normal');
    xlabel('$x$', 'Interpreter', 'latex', 'FontSize',14);
    ylabel('$y$', 'Interpreter', 'latex', 'FontSize',14);
    title('Fractal from $f(z)$', 'Interpreter', 'latex','FontSize', 16);
    
    export_fig(strcat(['/Users/s285/Downloads/NewtonZoom/ZoomDebug','-frame-',num2str(index)]), '-png', '-r200');
    
    clf;
    close all;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                  DEBUG AREA                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Debug_Z1 = Z(1);
DebugRoot1 = Roots(1);
DebugRoot2 = Roots(2);
DebugRoot3 = Roots(3);
%This location assumes that the computational engine requires no debugging.