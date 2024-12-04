%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Stockholm Doctoral Program in Economics
%                     Computational Bootcamp
%
%                  Exercise: Debugging in Matlab
%
%                      Kathrin Schlafmann
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

%% Question 1: Debugging
%this code recursively defines Chebychev Polynomials - there is a coding 
%error in this cell - can you find it?

clear
clc

npoints = 100;                      %number of points in grid
xvals = transpose(linspace(-1,1,npoints));     %grid
T = NaN(npoints,5);                 %matrix with polynomials

T(:,1) = 1;                         %the 3 equations that define the polynomial
T(:,2) = xvals;
for i=2:4
    T(:,i+1) = 2*xvals.*T(:,i) - T(:,i-1);
end

%plot the results:
figure(2)
plot(xvals,T)
legend('T_0(x)','T_1(x)','T_2(x)','T_3(x)','T_4(x)','Location','Eastoutside')


%% Question 2: Debugging with if-statements
clear
clc

CRRA = [4,3,2,1]';             %risk aversion
c = linspace(0.1,5,200);    %consumption

util_mat = NaN(length(CRRA),length(c));

for i=1:length(CRRA)
    
    if CRRA<=0
        error('inadmissible value for risk aversion')
    elseif CRRA(i)==1
        util_mat(i,:) = log(c);
    elseif CRRA>0
        util_mat(i,:) = c.^(1-CRRA(i))/(1-CRRA(i));
    end
    
end

figure(2)
plot(c,util_mat)
axis([0 5 -20 10])
legend( sprintf('CRRA = %d',CRRA(1)),...
        sprintf('CRRA = %d',CRRA(2)),...
        sprintf('CRRA = %d',CRRA(3)),...
        sprintf('CRRA = %d',CRRA(4)),...
        'Location','Southeast' ...
        )

    
%% Question 3: Debugging in a script cont'd
clear
clc

Nobs = 10000;       %number of observations in each sample
T = 1000;           %number of repetitions

mu = 0.1;           %true mean of the variable
sigma = 1.2;        %true std         ''

mu_hat = NaN(T,1);  %initalize the result matrix of estimates

for i=1:T
    
    rng(5679)
    mu_hat(i) = mean(mu + sigma*randn(Nobs,1)); %random draw of the sample and computation of mean
   
end

mean_mu = mean(mu_hat); %compute mean of estimates
std_mu = std(mu_hat);   %compute standard deviation of estimates
fprintf('mean estimate of mu = %1.4f \n', mean_mu)
fprintf('standard error of mu_hat = %1.4f \n', std_mu)

figure(1)                   %plot histogram of estimates of mu_hat
histogram(mu_hat,50)
hold on
plot(mu*ones(10,1),linspace(0,T/10,10),'-r','LineWidth',2)
hold off


%% Question 4: Debugging with Functions

clear
clc

%-----------
%(a)
x1 = 2;
x2 = 5;
[y1,y2,y3,y4] = secondFunction(x1,x2);

%-----------
%(b) having vectors as inputs (to avoid loops)
var1 = [2 3 7 10]';             %these are the two vectors with the values
var2 = [4 0.5 20 2]';           %you are interested in (you want to compute 
                                %the function for the set of 1st elements, 
                                %2nd elements, and so on)

%call the function here:
%XXXXXXXXXXXXXXXXX



%% Question 5: Debugging with functions cont'd

clear
clc

data = rand(200,5);             %some data matrix

data_stdzed = moreComplicatedFunction(data);


%% Question 6:  Debugging with functions cont'd

clear
clc

T=100;
pop1_0 = 1;
pop2_0 = 1;

[pop1, pop2] = getPopulation(T,pop1_0,pop2_0);

figure(1)
plot(1:T,[pop1 pop2])
legend('pop1','pop2','Location','Northeast')


