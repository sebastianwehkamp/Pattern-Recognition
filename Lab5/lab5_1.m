%load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');
% Plot both datasets
scatter(matA(:,1),matA(:,2))
hold on
scatter(matB(:,1),matB(:,2))
% Add legend
legend('matA', 'matB')
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

numLabels = 2;
% Initialize prototypes
prototypeLabels = [];
prototypes = [];
for j = 1:2
    % Determine label of this prototype
    currentLabel = mod(j, numLabels) + 1;
    prototypeLabels = [prototypeLabels; currentLabel];
    meanOfLabel = mean(data(labels == currentLabel));
    % Place randomly near mean
    newPos = meanOfLabel + (rand([1 2]) - 0.5 .* (1/10 * meanOfLabel));
    prototypes = [prototypes; newPos];
end
[predictedLabels, errors, prototypes, prototypeLabels] = lvq1(reshape(data, 200, 2), reshape(labels, 200, 1), reshape(data, 200, 2), prototypes, prototypeLabels, 1000);
figure;
%plot(errors);
%xlabel('Epochs');
%ylabel('Error rate');
subplot(2,2,1);
gscatter(reshape(data(:,:,1), 200, 1), reshape(data(:,:,2), 200, 1), predictedLabels, ['r' 'b'], 'o', 3, 'off');
hold on;
gscatter(prototypes(:, 1), prototypes(:, 2), prototypeLabels, ['r' 'b'], '+', 10, 'off');

prototypeLabels = [];
prototypes = [];
for j = 1:3
    % Determine label of this prototype
    currentLabel = mod(j, numLabels) + 1;
    prototypeLabels = [prototypeLabels; currentLabel];
    meanOfLabel = mean(data(labels == currentLabel));
    % Place randomly near mean
    newPos = meanOfLabel + (rand([1 2]) - 0.5 .* (1/10 * meanOfLabel));
    prototypes = [prototypes; newPos];
end
[predictedLabels, errors, prototypes, prototypeLabels] = lvq1(reshape(data, 200, 2), reshape(labels, 200, 1), reshape(data, 200, 2), prototypes, prototypeLabels, 1000);

%plot(errors);
subplot(2,2,2);
gscatter(reshape(data(:,:,1), 200, 1), reshape(data(:,:,2), 200, 1), predictedLabels, ['r' 'b'], 'o', 3, 'off');
hold on;
gscatter(prototypes(:, 1), prototypes(:, 2), prototypeLabels, ['r' 'b'], '+', 10, 'off');

prototypeLabels = [];
prototypes = [];
for j = 1:3
    % Determine label of this prototype
    currentLabel = mod(j-1, numLabels) + 1;
    prototypeLabels = [prototypeLabels; currentLabel];
    meanOfLabel = mean(data(labels == currentLabel));
    % Place randomly near mean
    newPos = meanOfLabel + (rand([1 2]) - 0.5 .* (1/10 * meanOfLabel));
    prototypes = [prototypes; newPos];
end
[predictedLabels, errors, prototypes, prototypeLabels] = lvq1(reshape(data, 200, 2), reshape(labels, 200, 1), reshape(data, 200, 2), prototypes, prototypeLabels, 1000);

%plot(errors);
subplot(2,2,3);
gscatter(reshape(data(:,:,1), 200, 1), reshape(data(:,:,2), 200, 1), predictedLabels, ['r' 'b'], 'o', 3, 'off');
hold on;
gscatter(prototypes(:, 1), prototypes(:, 2), prototypeLabels, ['r' 'b'], '+', 10, 'off');

prototypeLabels = [];
prototypes = [];
for j = 1:4
    % Determine label of this prototype
    currentLabel = mod(j, numLabels) + 1;
    prototypeLabels = [prototypeLabels; currentLabel];
    meanOfLabel = mean(data(labels == currentLabel));
    % Place randomly near mean
    newPos = meanOfLabel + (rand([1 2]) - 0.5 .* (1/10 * meanOfLabel));
    prototypes = [prototypes; newPos];
end
[predictedLabels, errors, prototypes, prototypeLabels] = lvq1(reshape(data, 200, 2), reshape(labels, 200, 1), reshape(data, 200, 2), prototypes, prototypeLabels, 1000);

%plot(errors);
%h = legend("1-1", "1-2", "2-1", "2-2");
%set(h, 'Location', 'southeast');
subplot(2,2,4);
gscatter(reshape(data(:,:,1), 200, 1), reshape(data(:,:,2), 200, 1), predictedLabels, ['r' 'b'], 'o', 3, 'off');
hold on;
gscatter(prototypes(:, 1), prototypes(:, 2), prototypeLabels, ['r' 'b'], '+', 10, 'off');
