function [] = exercise4()
    question1();
end

function [] = question1()
    results = randomWalk(100);
    for i=1:1000000
        results = [results, randomWalk(100)];
    end
    hist(results)
end

function [value] = randomWalk(numberTurns)
    value = 0;
    for i=1:numberTurns
       coin = randi(2);
       if coin == 1
           value = value + 1;
       end
    end
end