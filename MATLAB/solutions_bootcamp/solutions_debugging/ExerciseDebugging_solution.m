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
xvals = linspace(-1,1,npoints)';    %grid
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%the bug is the following: when you construct the vector xvals it is a ROW
%                          VECTOR; the code later on assumes it is a COLUMN 
%                          VECTOR; solution: construct it directly as a 
%                          column vector
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Question 2: Debugging with if-statements
clear
clc

CRRA = [4,3,2,1]';             %risk aversion
c = linspace(0.1,5,200);    %consumption

util_mat = NaN(length(CRRA),length(c));

for i=1:length(CRRA)
    
    if CRRA(i)<=0
        error('inadmissible value for risk aversion')
    elseif CRRA(i)==1
        util_mat(i,:) = log(c);
    elseif CRRA(i)>0
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%there are 2 bugs:
% 1) within the for-loop, the code refers to the whole vector CRRA instead
%    of only the i-th element of each iteration (need to change to CRRA(i))
%    inside the for-loop
% 2) the order of the if-statements is incorrect: since 1 is larger than
%    zero the code never checks the condition CRRA(i)==1 (the code hence
%    divides by zero and the result is Inf, which is why there is no graph 
%    for the CRRA=1 line in the plot)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Question 3: Debugging in a script cont'd
clear
clc

Nobs = 10000;       %number of observations in each sample
T = 1000;           %number of repetitions

mu = 0.1;           %true mean of the variable
sigma = 1.2;        %true std         ''

mu_hat = NaN(T,1);  %initalize the result matrix of estimates

rng(5679)

for i=1:T
    
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%the bug is the following: the code sets the seed within the loop, ie it
%                          draws exactly the same sample in each iteration.
%                          That is the opposite of what a Monte Carlo
%                          Simulation wants to do. We need to move the
%                          setting of the seed to the outside of the loop.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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
[out1,out2,out3,out4] = secondFunction(var1,var2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%the bug is the following: you need to use element-by-element operations so
%                          that matlab doesn't try to do matrix  
%                          multiplication when you supply vectors or 
%                          matrices.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Question 5: Debugging with functions cont'd

clear
clc

data = rand(200,5);             %some data matrix

data_stdzed = moreComplicatedFunction(data);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%the bug is the following: in the function you want to loop over the ROWS
%                          of the matrix; in the loop you are trying to 
%                          replace the COLUMNS though
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Question 6:  Debugging with functions cont'd

clear
clc

T=100;
pop1_0 = 1;
pop2_0 = 1;

[pop1, pop2] = getPopulation3(T,pop1_0,pop2_0);

figure()
plot(1:T,[pop1 pop2])
legend('pop1','pop2','Location','Northeast')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SPOILER:
%the bug is the following: the for-loop loops over t=1:T, but inside the
%                          loop the function computes the population sizes
%                          in the following period, ie until T+1; solution:
%                          we need to adjust to loop only until T-1;
%                          alternatively, we can run from 2:T but determine
%                          population growth as a function of last periods
%                          populations (see functions getPopulation2.m and
%                          getPopulation3.m)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

