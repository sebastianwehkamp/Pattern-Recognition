function [value] = exercise1()
    matrix = [4 6 8 7 3; 5 3 7 4 6; 6 9 3 8 5];
    means = calcMeans(matrix);
    matrix = matrix.'
    means = means.'
    covMatrix = covMat(matrix)
    F = probDens(matrix, covMatrix, means);
end

function [means] = calcMeans(matrix)
    means = mean(matrix,2);
end

function [C] = covMat(matrix)
    C = cov(matrix);
end

function [F] = probDens(matrix, covMatrix, means)
    %normDist = mvnrnd(means, covMatrix);
    prob1 = mvnpdf([5 5 6], means, covMatrix);
    prob2 = mvnpdf([3 5 7], means, covMatrix);
    prob3 = mvnpdf([4 6.5 1], means, covMatrix);
    fprintf('prob1 = %6.6f, prob2 = %6.6f, prob3 = %6.6f\n', prob1, prob2, prob3) 
    F = [prob1 prob2 prob3];
end