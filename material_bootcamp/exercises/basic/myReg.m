function [outputArg1] = myReg(inputArg1,inputArg2)
%MYREG Summary of this function goes here
%   Detailed explanation goes here
outputArg1 = inv(transpose(inputArg1)*inputArg1)*transpose(inputArg1)*inputArg2 ;
end

