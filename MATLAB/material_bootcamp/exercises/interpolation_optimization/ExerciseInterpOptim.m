%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Stockholm Doctoral Program in Economics
%                     Computational Bootcamp
%
%         Exercise: Interpolation and Optimization in Matlab
%
%                      Kathrin Schlafmann
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Question 1: 1-D interpolation
clear all
clc

vfunc = @(x) 0.25*x.^5-1.2*x.^4;     %true function
minx = -2;
maxx = 5;

%----------
%points available for interpolation:
x = linspace(minx,maxx,100);          %grid
v = vfunc(x);                        %function values at these grid points

%----------
%(a)-(c) interpolation:
xq = linspace(minx,maxx,29);         %points to evaluate (interpolate) function at

vq_linear  = interp1(x,v,xq,"linear")   %linear interpolation
vq_spline  = interp1(x,v,xq,"spline")   %spline interpolation
vq_nearest = interp1(x,v,xq,"nearest")   %nearest neighbor interpolation
vq_pchip   = interp1(x,v,xq,"pchip")   %pchip interpolation


%plot:
xtrue = linspace(minx,maxx,50);      %a fine grid to show the 'true' function
vtrue = vfunc(xtrue);                %values at this true function

figure(1)
scatter(x,v,'HandleVisibility','off')
hold on
plot(xtrue,vtrue,'-k','LineWidth',1)
plot(xq,vq_linear,'-b','LineWidth',2)
plot(xq,vq_spline,'-r','LineWidth',2)
plot(xq,vq_nearest,'-g','LineWidth',2)
plot(xq,vq_pchip,'-m','LineWidth',2)
hold off
legend( 'true function',...
        'linear interpolation',...
        'spline interpolation',...
        'nearest neightbor interpolation',...
        'pchip interpolation',...
        'Location','Northwest')


%----------
%(d) extrapolation:
xq = linspace(minx-2,maxx+3,29);         %points to evaluate (interpolate) function at

vq_linear_extrap  = interp1(x,v,xq,"linear", "extrap")   %linear interpolation
vq_spline_extrap  =interp1(x,v,xq,"spline", "extrap")    %spline interpolation
vq_nearest_extrap =interp1(x,v,xq,"nearest", "extrap")   %nearest neighbor interpolation
vq_pchip_extrap   =interp1(x,v,xq,"pchip", "extrap")     %pchip interpolation


%plot:
xtrue = linspace(minx-2,maxx+3,50);      %a fine grid to show the 'true' function
vtrue = vfunc(xtrue);                %values at this true function

figure(2)
scatter(x,v,'HandleVisibility','off')
hold on
plot(xtrue,vtrue,'-k','LineWidth',1)
plot(xq,vq_linear_extrap,'-b','LineWidth',2)
plot(xq,vq_spline_extrap,'-r','LineWidth',2)
plot(xq,vq_nearest_extrap,'-g','LineWidth',2)
plot(xq,vq_pchip_extrap,'-m','LineWidth',2)
hold off
legend( 'true function',...
        'linear interpolation',...
        'spline interpolation',...
        'nearest neightbor interpolation',...
        'pchip interpolation',...
        'Location','Northwest')
   
%% Question 2: 2D interpolation
clear
clc

%---------
%(a) construct meshgrid:
% x = %XXXXXXXXXXXXXX             %16 linearly spaced points in range -2 and 2
% [X,Y] = %XXXXXXXXXXXXXX         %system of coordinates ('meshgrid')

%---------
%(b) corresponding value:
% V = %XXXXXXXXXXXXXX             %function values in sample (on the grid)
figure(1)
surf(X,Y,V)
title('available sample')

%---------
%(c) interpolation:

% xq = %XXXXXXXXXXXXXX            %query points: 40 linearly spaced points in range -2 and 2
% [Xq,Yq] = %XXXXXXXXXXXXXX       %grid for query

%linear:
Vq_linear = %XXXXXXXXXXXXXX   %linear interpolation
figure(2)
surf(Xq,Yq,Vq_linear)
title('linear interpolation')

%spline:
Vq_spline = %XXXXXXXXXXXXXX   %spline interpolation
figure(3)
surf(Xq,Yq,Vq_spline)
title('spline interpolation')



%% Question 3: repeated interpolation of the same function

clear
clc

%-------
%(a) construct sample
%XXXXXXXXXXXXXX
%XXXXXXXXXXXXXX
figure(1)
surf(X,Y,V)

%-------
%(b) evalauate repeatedly with interp2()
[Xq,Yq] = meshgrid(linspace(-2,2,100));
Xq = Xq(:);
Yq = Yq(:);

Vq_interp2 = NaN(size(Xq));

tic
for i=1:length(Xq)
%     Vq_interp2(i) = %XXXXXXXXXXXXXX
end
toc 


%-------
%(c) evalauate repeatedly with griddedInterpolant()
Vq_griddedInterp = NaN(size(Xq));

tic
%XXXXXXXXXXXXXX
for i=1:length(Xq)
%     Vq_griddedInterp(i) = %XXXXXXXXXXXXXX
end
toc 



%% Question 4: Optimization - grid search
clear
clc


%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grids:
xx = linspace(.01,10,50)
cc = linspace(.001,10,200)

%compute utlity of all possible combinations:
[XX,CC] = ndgrid(xx,cc);
UTIL = CRRAutility(CC,XX,R,beta,sigma)
%XXXXXXXXXXXXXX   %ensure that choices are feasible
UTIL = UTIL.*(CC<XX) + UTIL(CC=>XX) * (-1e20)
%pick consumption with maximum utility given value of x:
%XXXXXXXXXXXXXX
% c_opt = %XXXXXXXXXXXXXX



%plot optimal consumption:
figure(1)
plot(xx,c_opt)
title('optimal consumption through grid search')


%% Question 5: Optimization - fmincon
clear
clc


%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grid:
xx = %XXXXXXXXXXXXXX

%set options:
myoptions = optimset('Display','final');

%optimize using fmin
c_opt = NaN(size(xx));  %initialize result vector

% lb = %XXXXXXXXXXXXXX               %lower bound for consumption
% c_init = %XXXXXXXXXXXXXX       %initial guess as starting point for solver
for i=1:length(xx)
%     ub = %XXXXXXXXXXXXXX     %upper bound for consumption
%     c_opt(i) = fmincon(%XXXXXXXXXXXXXX);
end



%plot optimal consumption:
figure(2)
plot(xx,c_opt)
title('optimal consumption through fmincon')


%% Question 5: Optimization - fsolve
clear
clc


%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grid:
% xx = %XXXXXXXXXXXXXX

%set options:
myoptions = optimset('Display','final');

%optimize using fmin
c_opt = NaN(size(xx));  %initialize result vector

% c_init = %XXXXXXXXXXXXXX        %initial guess as starting point for solver
for i=1:length(xx)
%     c_opt(i) = fsolve(%XXXXXXXXXXXXXX);
end



%plot optimal consumption:
figure(3)
plot(xx,c_opt)
title('optimal consumption through fsolve')
