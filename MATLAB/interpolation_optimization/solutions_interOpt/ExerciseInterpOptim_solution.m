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


%% Question 1: 1D interpolation
clear all
clc

vfunc = @(x) 0.25*x.^5-1.2*x.^4;     %true function
minx = -2;
maxx = 5;

%----------
%points available for interpolation:
x = linspace(minx,maxx,15);          %grid
v = vfunc(x);                        %function values at these grid points

%----------
%(a)-(c) interpolation:
xq = linspace(minx,maxx,29);         %points to evaluate (interpolate) function at

vq_linear  = interp1(x,v,xq,'linear','extrap');   %linear interpolation
vq_spline  = interp1(x,v,xq,'spline','extrap');   %spline interpolation
vq_nearest = interp1(x,v,xq,'nearest','extrap');  %nearest neighbor interpolation
vq_pchip   = interp1(x,v,xq,'pchip','extrap');    %pchip interpolation


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
%(c) Nearest neighbor interpolation makes sense if you are working with an
%    indicator function (a function that only takes on discrete values). In
%    this case other interpolation methods do not make much sense since
%    values outside the set of these discrete values are not meaningful.

    
%----------
%(d) extrapolation:
xq = linspace(minx-2,maxx+3,29);         %points to evaluate (interpolate) function at

vq_linear_extrap  = interp1(x,v,xq,'linear','extrap');   %linear interpolation
vq_spline_extrap  = interp1(x,v,xq,'spline','extrap');   %spline interpolation
vq_nearest_extrap = interp1(x,v,xq,'nearest','extrap');  %nearest neighbor interpolation
vq_pchip_extrap   = interp1(x,v,xq,'pchip','extrap');    %pchip interpolation


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

%----------
%(e) The closeness to the true function is *not* a general feature of the
%    methods! It depends on your function, and in practice you don't know 
%    which one will be off the most. Be very careful when using
%    extrapolation and do so only very close to the grid you have solved
%    for!
    



%% Question 2: 2D interpolation
clear
clc

%---------
%(a) construct meshgrid:
x = linspace(-2,2,16);      %16 linearly spaced points in range -2 and 2
[X,Y] = meshgrid(x);        %system of coordinates ('meshgrid')

%---------
%(b) corresponding value:
V = X.*exp(-X.^2-Y.^2);     %function values in sample (on the grid)
figure(1)
surf(X,Y,V)
title('available sample')

%---------
%(c) interpolation:

xq = linspace(-2,2,40);     %query points: 40 linearly spaced points in range -2 and 2
[Xq,Yq] = meshgrid(xq);     %grid for query

%linear:
Vq_linear = interp2(X,Y,V,Xq,Yq,'linear')   %linear interpolation
figure(2)
surf(Xq,Yq,Vq_linear)
title('linear interpolation')

%spline:
Vq_spline = interp2(X,Y,V,Xq,Yq,'spline')   %spline interpolation
figure(3)
surf(Xq,Yq,Vq_spline)
title('spline interpolation')



%% Question 3: repeated interpolation of the same function

clear
clc

%-------
%(a) construct sample
[X,Y] = meshgrid(linspace(-2,2,50));
R = sqrt(X.^2 + Y.^2)+ eps;
V = sin(R)./(R);
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
    Vq_interp2(i) = interp2(X,Y,V,Xq(i),Yq(i),'spline');
end
toc 


%-------
%(c) evalauate repeatedly with griddedInterpolant()
Vq_griddedInterp = NaN(size(Xq));

tic
F = griddedInterpolant(X',Y',V','spline');
for i=1:length(Xq)
    Vq_griddedInterp(i) = F(Xq(i),Yq(i));
end
toc 


%% Question 4: Optimization - grid search
clear
% clc

tic
%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grids:
xx = linspace(0.01,10,50)';
cc = linspace(0.001,10,200)';

%compute utlity of all possible combinations:
[XX,CC] = ndgrid(xx,cc);
UTIL = CRRAutility_solution(CC,XX,R,beta,sigma);
UTIL = UTIL.*(CC<XX) + (CC>XX).* (-1e20);   %ensure that choices are feasible

%pick consumption with maximum utility given value of x:
[util_x, c_ind] = max(UTIL,[],2);
c_opt = cc(c_ind');

toc

%plot optimal consumption:
figure(1)
plot(xx,c_opt)
title('optimal consumption through grid search')


%% Question 5: Optimization - fmincon
clear
clc

tic
%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grid:
xx = linspace(0.01,10,50)';

%set options:
myoptions = optimset('Display','final');

%optimize using fmin
c_opt = NaN(size(xx));  %initialize result vector

lb = eps;               %lower bound for consumption
c_init = 0.5*xx;        %initial guess as starting point for solver
for i=1:length(xx)
    ub = xx(i)-eps;     %upper bound for consumption
    c_opt(i) = fmincon(@(c) -CRRAutility_solution(c,xx(i),R,beta,sigma), c_init(i),[],[],[],[],lb,ub,[],myoptions);
end

toc

%plot optimal consumption:
figure(2)
plot(xx,c_opt)
title('optimal consumption through fmincon')


%% Question 6: Optimization - fsolve
clear
clc

tic
%set parameters:
beta = 0.95;    %discount factor
R = 1.02;       %interest rate
sigma = 2;      %risk aversion

%construct grid:
xx = linspace(0.01,10,50)';

%set options:
myoptions = optimset('Display','final');

%optimize using fmin
c_opt = NaN(size(xx));  %initialize result vector

c_init = 0.5*xx;        %initial guess as starting point for solver
for i=1:length(xx)
    c_opt(i) = fsolve(@(c) EulerEquationDifference_solution(c,xx(i),R,beta,sigma), c_init(i),myoptions);
end

toc

%plot optimal consumption:
figure(3)
plot(xx,c_opt)
title('optimal consumption through fsolve')
