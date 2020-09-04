% Init points
x1 = [0; 0];
x2 = [2; 3];
x3 = [1; 4];
x4 = [4; 2];
x5 = [3; 0];

% Init clusters
cluster1 = [x1 x2 x3];
cluster2 = [x4 x5];

% Calculate means
meanClust1 = mean(cluster1, 2);
meanClust2 = mean(cluster2, 2);

% Calculate distances to means and sum
distClust1 = sum(pdist2(cluster1', meanClust1', 'squaredeuclidean'));
distClust2 = sum(pdist2(cluster2', meanClust2', 'squaredeuclidean'));

% Sum to get error
error = distClust1 + distClust2

% Plot result
scatter(cluster1(1,:), cluster1(2,:))
hold on
scatter(cluster2(1,:), cluster2(2,:))
hold off