load('kmeans1.mat')
kmax = 10;


% Compute J(k) for k = 1...kmax
J = []; R = []; D = [];
for k=1:kmax
    [assignment, means, meanArray,  error] = kmeans(kmeans1, k, false);
    J = [J; error];
    % Compute R
    R = [R; J(1)*k^(-1)];
    % Compute D(k)
    D = [D; R(k)/J(k)]; 
end

% Plot correctly
plot(J);
hold on;
plot(R);
ylim([0 max(max(J), max(R))]);
legend('J(k)', 'R(k)');
[maxVal, idx] = max(D);
l = line([idx idx], [0 max(max(J), max(R))]);
l.DisplayName = 'Kopt';
l.Color = 'green';

xlabel('k');