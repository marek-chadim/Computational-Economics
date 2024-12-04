function [pop1, pop2] = getPopulation2(T,pop1_0,pop2_0)

    pop1 = NaN(T,1);
    pop2 = NaN(T,1);

    pop1(1) = pop1_0;
    pop2(1) = pop2_0;
    
    if pop1(1)>=pop2(1)
        g_pop1 = 0.5;
    else
        g_pop1 = 1.5;
    end

    for t=2:T

        pop1(t) = pop1(t-1)*g_pop1;
        pop2(t) = pop2(t-1)*1.45 - 0.5*pop1(t-1);
        
        if pop1(t)>=pop2(t)
            g_pop1 = 0.5;
        else
            g_pop1 = 1.5;
        end

    end

end