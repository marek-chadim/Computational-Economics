function  u = CRRAutility(c,x,R,beta,sigma)

    c1 = c
    c2 = (x-c)*R
    u  = c.^(1-sigma)/(1-sigma) + beta*c2.^(1-sigma)/(1-sigma)
       
end