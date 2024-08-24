function EEdiff = EulerEquationDifference(c,x,R,beta,sigma)

    c1 = c;
    c2 = (x-c)*R;

    LHS = c1.^(-sigma);
    RHS = beta*R*c2.^(-sigma);
    
    EEdiff = LHS - RHS;

end