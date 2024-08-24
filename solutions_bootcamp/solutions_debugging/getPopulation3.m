function [pop1, pop2] = getPopulation3(T,pop1_0,pop2_0)

    pop1 = NaN(T,1);
    pop2 = NaN(T,1);

    pop1(1) = pop1_0;
    pop2(1) = pop2_0;
    
    g_pop1 = getGrowth(pop1(1), pop2(1));

    for t=2:T

        pop1(t) = pop1(t-1)*g_pop1;
        pop2(t) = pop2(t-1)*1.45 - 0.5*pop1(t-1);
        
        g_pop1 = getGrowth(pop1(t), pop2(t));

    end

end

function growthrate = getGrowth(pop1, pop2)

    if pop1>=pop2
        growthrate = 0.5;
    else
        growthrate = 1.5;
    end

end