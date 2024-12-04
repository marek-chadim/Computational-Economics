function [x,y,z,w] = firstFunction(a,b)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function firstFunction.m:
%
%computes the sum, difference, product and product of squares 
%
%inputs: 2 scalars (a and b)
%
%outputs: x - sum
%         y - difference a-b
%         z - product
%         w - sum of squares
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = a + b;
y = a - b;
z = a * b;
w = a^2 + b^2;

end