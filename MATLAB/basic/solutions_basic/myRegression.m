function beta = myRegression(X,y)
    beta = (X'*X)^(-1)*X'*y;
end