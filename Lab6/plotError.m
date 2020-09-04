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

findpeaks(D, 'NPeaks', 1);

xlabel('k');
ylabel('D(k)');