%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Stockholm Doctoral Program in Economics
%                     Computational Bootcamp
%
%                   Exercise: Basics in Matlab
%
%                      Kathrin Schlafmann
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc



%% Question 4: What does this code do?
clear
clc

nloops = 100;                       %number of loop iterations and length of vector
approx = NaN(nloops,1);             %output - initialize with NaN
trueval = NaN(nloops,1);            %output - initialize with NaN

xvals = linspace(0.1,10,nloops);    
for i=1:nloops
    x = xvals(i);
    trueval(i) = log(1+1/x);
    approx(i) = 1/x;
end

figure(1)
subplot(2,1,1)
plot(xvals,trueval,'-b','LineWidth',1.5)
hold on
plot(xvals,approx,'-r','LineWidth',1.5)
hold off
title('Approximation vs True Value')
legend('True Value','Approximation','Location','Northeast')

subplot(2,1,2)
plot(xvals,approx-trueval,'-r','LineWidth',1.5)
title('Approximation Error')


%-----------------
%f) rewrite without loop and test equivalence:
trueval2 = log(1+1./xvals)
approx2 = 1./xvals


%clear nloops trueval approx xvals i x trueval2 approx2 




%% Question 5: Working with for-loops
clear
clc

total = 0;      %this variable will be the sum of the numbers (the result)
for i=1:100
    total= total+i            %update the variable total here
end

%-----------------
%b) rewrite without loop:
vectotal=(1:100)
total2= sum(vectotal)
%-----------------
%c) rewrite in one line:
sum((1:100))
clear total* i



%% Question 6: Working with if-statements

clear
clc

%a) display a different text depending on the value of x
x = inf;
%write your if-statement here
if x <50
    disp('value is less than fifty')
elseif x<100
    disp('value is more than or equal to fifty but less than 100')
else
    disp('value is more than 100')
end
%b) allow for 3 thresholds
x = 50;
%write your if-statement here
~ˇ^˘°˛`˙´´˝
clear x

%% Question 7: Working with functions

var1 = 2;
var2 = 5;

[x,y,z,w] = firstFunction(var1,var2);


%% Question 8: Working with functions cont'd
clear
clc

%-----------
%(a) manually coding OLS regressions
X = [ones(150,1) rand(150,3)];                      %exogenous regressors
y = 3*X(:,1) + 0.5*X(:,2) - 5*X(:,3) - 0.1*X(:,4);  %dependent variable

beta = inv(transpose(X)*X)*transpose(X)*y           %OLS coefficient estimate
 

%-----------
%(b) writing a function to compute OLS coefficients
y2 = 7*X(:,1) - 5*X(:,2) - 3*X(:,3) - 0.1*X(:,4);   %more variables of interest
y3 = 0.5*X(:,2) + 2*X(:,3) - 3*X(:,4);
y4 = 4*X(:,1) - 0.5*X(:,2);

%beta = %XXXXXXXXXX 
beta = myReg(X,y2)

%-----------
%(c) Systematically computing OLS for all dependent variables using a loop
ys = [y2; y3; y4];
for i = 1:3
    betas(i) = myReg(X, ys(:,i));  % Update the variable 'total' here (if needed)
end



%% Question 9: Monte Carlo Simulation
clear
clc

Nobs = 20;          %number of observations in each sample
T = 1000;           %number of repetitions

a = 0.1;            %intercept of true relationship y = a + b*x
b = 1.2;            %slope                  ''
sigma_eps = 0.05;    %standard deviation of noise

beta_vec = NaN(T,2);    %initalize the result matrix of estimates

for i=1:T
    
     x = randn(Nobs,1)              %random draw of the sample (size Nobs)
     eps = sigma_eps*randn(Nobs,1)           %random draw of noise (size Nobs)
     y = a + b*x + epsilon              %corresponding values y
    
%    beta_vec(i,:) = %XXXXXXXXXXXXX  %save estimate from each run
    clear x y
   
end

mean_beta = mean(beta_vec); %compute mean of estimates
std_beta = std(beta_vec);   %compute standard deviation of estimates
fprintf('mean estimate of b = %1.4f \n', mean_beta(2))
fprintf('standard error = %1.4f \n', std_beta(2))

figure(1)                   %plot histogram of estimates of b
histogram(beta_vec(:,2),50)
hold on
plot(b*ones(10,1),linspace(0,T/10,10),'-r','LineWidth',2)
hold off

