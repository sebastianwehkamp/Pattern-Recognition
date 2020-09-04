function [dist1, dist2] = exercise5()
    dist1 = createDist1()
    dist2 = createDist2()
end

function [cobj] = createDist1()
    mu = [3 5];
    sigma = [1 0; 0 4];
    prior = 0.3;
    cobj = makecdiscr(mu, sigma, 'Prior', prior);
    cobj.DiscrimType = 'quadratic'
end

function [cobj] = createDist2()
    mu = [2 1];
    sigma = [2 0; 0 1];
    prior = 0.7;
    cobj = makecdiscr(mu, sigma, 'Prior', prior);
    cobj.DiscrimType = 'quadratic'
end