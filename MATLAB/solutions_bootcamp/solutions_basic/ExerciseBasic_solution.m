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

%% Question 2: Vectors

clear
clc

%-----------------
%a) construct a row vector of ones (length 10)
aVec = [1 1 1 1 1 1 1 1 1 1];   %brute force (quite tedious, prone to error)
aVec = ones(1,10);              %the easiest way
aVec = repmat(1,1,10);          %not very efficient in this case (overkill 
                                %for such a simple problem)
                                
%-----------------
%b) ensure you did the right thing:
% - looking at the workspace (only helpful for very small objects)
% - opening cVec in the variables window (only helpful for objects that 
%   are not too big)
% - using functions several functions (most common way once your objects 
%   become larger), examples:
size(aVec)                      %gives you the dimensions of your object
min(aVec)                       %smallest elements in aVec
max(aVec)                       %largest element in aVec
min(aVec)==max(aVec)            %are all elements the same?
aVec==1                         %are all elements in aVec equal to one? 
                                %Generates an object of the same size as 
                                %aVec with zeros and ones: 1->the statement 
                                %is true, 0->the statement is false


%-----------------
%c) transpose of a vector
bVec = aVec';                   %works
bVec = transpose(aVec);         %does the same, faster

%-----------------
%d) replacing the second element:
cVec = bVec;
cVec(2) = 0;

%check that you did the right thing by: 
% - looking at the workspace (only helpful for very small objects)
% - opening cVec in the variables window (only helpful for objects that 
%   are not too big)
% - using functions several functions after another:
test = (cVec==bVec);            %generates element-by-element indicators 
                                %whether each of the elements is identical 
                                %between the two objects
                                
sum(test==0)                    %gives you the number of elements that are 
                                %different
                                
ind = find(test==0,1,'first');  %tells you the position where test is equal 
                                %to 0 (which has been constructed to mean 
                                %that the elemeents of bVec and cVec differ 
                                %there)
                                
cVec(ind)                       %display this element that is different


%-----------------
%d) replacing last-but-one element:
cVec = bVec;
cVec(end-1) = 0;                %'end' refers to the length of this dimension


%% Question 3: Matrices
clear
clc

%-----------------
%a) construct a row vector of ones (length 10)
aMat = [1 2 3 4; 4 3 2 1; 20 15 10 5]
%to make sure that you constructed the right thing, do the same steps as
%above: what is the size of your object? Play around with locating min
%and max etc.

%-----------------
%b) construction without typing each element:
bMat1 = (1:4);
bMat2 = (4:-1:1);
bMat3 = (20:-5:5);
bMat = [bMat1; bMat2; bMat3];

%-----------------
%c) are the two matrices identical?
isequal(aMat,bMat)              %this function returns 1 if they are 
                                %identical and 0 otherwise
%-----------------
%d) replacing a row of a matrix
cMat = bMat;
cMat(end,:) = 2*ones(1,size(cMat,2));

%-----------------
%e) if you compare cMat and aMat with isequal then the results is 0 (they
%   are not identical)


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
approx2 = transpose(1./xvals);
trueval2 = transpose(log(1+1./xvals));

isequal(approx,approx2)
isequal(trueval,trueval2)

clear nloops trueval approx xvals i x trueval2 approx2 




%% Question 5: Working with for-loops
clear
clc

total = 0;      %this variable will be the sum of the numbers (the result)
for i=1:100
    total = total + i;            %update the variable total here
end

%-----------------
%b) rewrite without loop:
help_vec = 1:100;
total2 = sum(help_vec);

%-----------------
%c) rewrite in one line:
total3 = sum(1:100);                %note: while this can be faster, if your 
                                    %expressions become more complicated 
                                    %then the readability of your code will 
                                    %be worse if you do everything in one 
                                    %line. This makes it more likely that 
                                    %you will make mistakes!

clear total* i



%% Question 6: Working with if-statements

clear
clc

%a) display a different text depending on the value of x
x = 50;
if x>100
    disp('value is larger than 100')
else
    disp('value is smaller than 100')
end

%b) allow for 3 thresholds
x = 50;
if x>200
    disp('value is larger than 200')
elseif x>100
    disp('value is between 100 and 200')
else
    disp('value is smaller than 100')
end

clear x

%% Question 7: Working with functions
clear
clc

var1 = 2;
var2 = 5;

[output1,output2,output3,output4] = firstFunction(var1,var2);


%% Question 8: Working with functions cont'd
clear
clc

%-----------
%(a) manually coding OLS regressions
X = [ones(150,1) rand(150,3)];                      %exogenous regressors
y = 3*X(:,1) + 0.5*X(:,2) - 5*X(:,3) - 0.1*X(:,4);  %dependent variable

beta = (X'*X)^(-1)*X'*y;                            %OLS coefficient estimate
 

%-----------
%(b) writing a function to compute OLS coefficients
y2 = 7*X(:,1) - 5*X(:,2) - 3*X(:,3) - 0.1*X(:,4);   %more variables of interest
y3 = 0.5*X(:,2) + 2*X(:,3) - 3*X(:,4);
y4 = 4*X(:,1) - 0.5*X(:,2);

beta = myRegression(X,y); 


%-----------
%(c) systematically computing OLS for all dependent variables using a loop

Y = [y y2 y3 y4];                           %put all dependent variables in 
                                            %a matrix (looping over variable 
                                            %names is possible more tedious)
                                            
beta_all = NaN(size(X,2),size(Y,2));        %initialize the output matrix
for i=1:size(Y,2)                           %loop over all dependent variables
    beta_all(:,i) = myRegression(X,Y(:,i));
end


%% Question 9: Monte Carlo Simulation
clear
% clc

Nobs = 20;          %number of observations in each sample
T = 1000;           %number of repetitions

a = 0.1;            %intercept of true relationship y = a + b*x
b = 1.2;            %slope                  ''
sigma_eps = 0.05;    %standard deviation of noise

beta_vec = NaN(T,2);    %initalize the result matrix of estimates

for i=1:T
    
    x = randn(Nobs,1);              %random draw of the sample (size Nobs)
    epsilon = sigma_eps*randn(Nobs,1);  %random draw of noise (size Nobs)
    y = a + b*x + epsilon;              %corresponding values y
    
    beta_vec(i,:) = myRegression([ones(Nobs,1) x],y);  %save estimate from each run
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


%--------------
%(c) get the same random draws each time you execute: set a seed before
%    going into the for-loop: rng(255)
%    note: the number 255 (=the seed) is arbitrary here (different seeds 
%          lead to different random draws, but for a given seed the draws 
%          are identical each time you execute 






