%load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');
%prepare arrays
data = zeros(10,20,2);
labels = zeros(10,20);
%split into 10 groups
for i=1:10
    %add 10 from class A
    data(i, 1:10, :) = matA((1:10)+(i-1)*10, :);
    %add 10 from class B
    data(i, 11:20, :) = matB((1:10)+(i-1)*10, :);
    %label them
    labels(i, 1:10) = 1;
    labels(i, 11:20) = 2;
end

errorVal = zeros(10,1);
for i=1:10
    [predictedLabels, errors, prototypes, prototypeLabels] = rlvq(reshape(data(horzcat(1:i-1, i+1:10), :, :), 180, 2), reshape(labels(horzcat(1:i-1, i+1:10), :), 180, 1), reshape(data(i, :, :), 20, 2), 4, 100);
    errorVal(i) = nnz(predictedLabels - labels(i, :)) / 20;
end

