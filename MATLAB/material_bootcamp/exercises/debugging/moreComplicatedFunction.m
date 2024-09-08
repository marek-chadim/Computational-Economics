function Xnew = moreComplicatedFunction(X)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%function moreComplicatedFunction.m
%
%this function standardizes a data matrix: 
%
%input: data matrix X
%
%output: matrix Xnew, the standardized version of X (each column will has 
%        mean=0 and standard deviation=1 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    meanX = mean(X);
    stdX = std(X);
    
    Xnew = NaN(size(X));
    for i=1:size(X,2)
        Xnew(:,i) = (X(:,i) -meanX(i))./stdX(i);
    end

end