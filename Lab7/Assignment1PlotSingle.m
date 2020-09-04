load('cluster_data.mat')
t= 0.18;

dist = pdist2(cluster_data,cluster_data);
idx = find(dist >= t);
dist(idx) = NaN;
[x,y] = size(dist);

scatter(cluster_data(:,1),cluster_data(:,2), 'filled');

hold on;
for i=1:x
    point1 = cluster_data(i,:);
    for j=1:y
        if ~isnan(dist(i,j))
            point2 = cluster_data(j,:);
            plot([point1(1) point2(1)], [point1(2) point2(2)], 'k');
        end
    end
end
xlabel('x-axis');
ylabel('y-axis');
title(['t = ' num2str(t)]);
hold off;
