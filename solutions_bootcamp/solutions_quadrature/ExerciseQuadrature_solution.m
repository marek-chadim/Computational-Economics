%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%             Stockholm Doctoral Program in Economics
%                     Computational Bootcamp
%
%       Exercise: Numerical Integration by Gauss-Hermite Quadrature
%
%                         Kathrin Schlafmann
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all
clc

N = 5;                          % number of quadrature nodes

[zeta,omega] = GaussHermite(N); % get quadrature nodes and weights


%% Question 1: expected value of standard normal variable
clearvars -except omega zeta N

%---------
%(a) Gauss-Hermite quadrature
mu = 0;     %mean
sigma = 1;  %standard deviation

temp = NaN(N,1);
HofEps = NaN(N,1);
for i=1:N
    HofEps(i) = (sqrt(2)*sigma*zeta(i) + mu);
    temp(i) = 1/sqrt(pi) * omega(i) * HofEps(i);
end
Eeps = sum(temp);

fprintf('Question 1a: E[eps] = %1.4f \n', Eeps)

%---------
%(b) random draws from normal distribution
Eeps2 = mean(randn(1000000,1))  %note: even with 1 million draws there is 
                                %      still a lot of randomness in the 
                                %      mean!!!
                                %      -> quadrature is so much more
                                %         efficient and precise!

%% Question 2: expected value of a normal variable
clearvars -except omega zeta N

mu = 2;     %mean
sigma = 2;  %standard deviation

temp = NaN(N,1);
for i=1:N
    temp(i) = 1/sqrt(pi) * omega(i) * (sqrt(2)*sigma*zeta(i) + mu);
end
Eeps = sum(temp);

fprintf('Question 2: E[eps] = %1.4f \n', Eeps)

%% Question 3: expected profits if output Y is normally distributed
clearvars -except omega zeta N

w = 1;      %wage rate
L = 10;     %labor input
r = 0.1;    %interst on capital
K = 100;    %capital input

mu = 100;   %mean of output Y
sigma = 5;  %standard deviation of Y

temp = NaN(N,1);
for i=1:N
    temp(i) = 1/sqrt(pi) * omega(i) * (sqrt(2)*sigma*zeta(i) + mu);
end
EY = sum(temp);
EPi = EY - w*L - r*K;

fprintf('Question 3: E[Pi] = %1.4f \n', EPi)


%% Question 4: expected value if labor is normally distributed
clearvars -except omega zeta N

w = 1;      %wage rate
r = 0.1;    %interst on capital
K = 100;    %capital input
alpha = 0.3;%capital share in output

mu = 10;    %mean of labor
sigma = 1;  %standard deviation of labor

temp = NaN(N,1);
L = NaN(N,1);
Y = NaN(N,1);
HofL = NaN(N,1);
for i=1:N
    L(i) = (sqrt(2)*sigma*zeta(i) + mu);
    Y(i) = 5 * L(i)^(1-alpha) * K^alpha;
    HofL(i) = Y(i) - w*L(i) - r*K;
    temp(i) = 1/sqrt(pi) * omega(i) * HofL(i);
end
EPi = sum(temp);

fprintf('Question 4: E[Pi] = %1.4f \n', EPi)



%% Question 5: expected income if income is lognormally distributed
clearvars -except omega zeta N

sigma = 0.1;        %variation parameter of lognormal distribution
mu = -0.5*sigma^2;  %mean parameter of lognormal distribution - this 
                    %specification ensures that mean = 1

temp = NaN(N,1);
for i=1:N
    temp(i) = 1/sqrt(pi) * omega(i) * exp(sqrt(2)*sigma*zeta(i) + mu);
end
EY = sum(temp);

fprintf('Question 5: E[Y] = %1.4f \n', EY)



%% Question 6: expected income if income is a random walk in logs
clearvars -except omega zeta N

sigma = 0.1;        %variation parameter of lognormal distribution
mu = -0.5*sigma^2;  %mean parameter of lognormal distribution - this 
                    %specification ensures that mean = 1

Y_t = [1 2 3];      %grid for income in current period

temp = NaN(N,length(Y_t));
for i=1:N
    temp(i,:) = 1/sqrt(pi) * omega(i) * Y_t * exp(sqrt(2)*sigma*zeta(i) + mu);
end
EY = sum(temp);

fprintf('Question 6: E[Y|Y(-1)] = %1.4f \n', EY(1))
fprintf('                         %1.4f \n', EY(2))
fprintf('                         %1.4f \n', EY(3))




%% Question 7: expected after-tax income if tax schedule is step-wise linear
clearvars -except omega zeta N

sigma = 0.3;    %variation parameter of lognormal distribution
mu = 3;         %mean parameter of lognormal distribution

temp = NaN(N,1);
Y = NaN(N,1);
TY = NaN(N,1);
for i=1:N
    Y(i) = exp(sqrt(2)*sigma*zeta(i) + mu);
    if Y(i) < 10
        TY(i) = 0;
    elseif Y(i) < 20
        TY(i) = 0.2*Y(i);
    else
        TY(i) = 0.3*Y(i);
    end
    temp(i) = 1/sqrt(pi) * omega(i) * (Y(i)-TY(i));
end
EY = sum(temp);

fprintf('Question 7: E[Y] = %1.4f \n', EY)



