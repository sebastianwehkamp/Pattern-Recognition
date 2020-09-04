%load data
load('data_lvq_A.mat');
load('data_lvq_B.mat');
% Plot both datasets
scatter(matA(:,1),matA(:,2))
hold on
scatter(matB(:,1),matB(:,2))
% Add legend
legend('matA', 'matB')