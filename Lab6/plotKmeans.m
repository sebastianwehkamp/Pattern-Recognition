load('kmeans1.mat')

% Plot classification k = 2
% Run kmeans
[assignment, means] = kmeans(kmeans1, 2, false);
subplot(3,1,1);
gscatter(kmeans1(:,1),kmeans1(:,2), assignment(:,1), '', ['x' 'o' '+' 's' 'd' 'p' 'v' '^'], '', 'off')
% Plot means
hold on
scatter(means(:,1),means(:,2), 100, '*', 'k');
title('k = 2');

% Plot classification k = 4
% Run kmeans
[assignment, means] = kmeans(kmeans1, 4, false);
subplot(3,1,2);
gscatter(kmeans1(:,1),kmeans1(:,2), assignment(:,1), '', ['x' 'o' '+' 's' 'd' 'p' 'v' '^'], '', 'off')
% Plot means
hold on
scatter(means(:,1),means(:,2), 100, '*', 'k');
title('k = 4');

% Plot classification k = 8
% Run kmeans
[assignment, means] = kmeans(kmeans1, 8, false);
subplot(3,1,3);
gscatter(kmeans1(:,1),kmeans1(:,2), assignment(:,1), '', ['x' 'o' '+' 's' 'd' 'p' 'v' '^'], '', 'off')
% Plot means
hold on
scatter(means(:,1),means(:,2), 100, '*', 'k');
title('k = 8');