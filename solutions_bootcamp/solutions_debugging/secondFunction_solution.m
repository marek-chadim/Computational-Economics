function [x,y,z,w] = secondFunction(a,b)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function secondFunction.m:
%
%computes the sum, difference, product and sum of squares of the input 
%variables 
%
%inputs: either two scalars, a scalar and a matrix, or two matrices of
%        identical size (uses element-by-element operations then)
%
%outputs: x - sum
%         y - difference 
%         z - product
%         w - sum of squares
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = a + b;
y = a - b;
z = a .* b;
w = a.^2 + b.^2;

end