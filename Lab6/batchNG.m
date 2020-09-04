function [prototypes] = batchNG(Data, n, epochs, xdim, ydim)

    % Used in plotting
    L = 0;
    
    % Batch Neural Gas
    %   Data contains data,
    %   n is the number of clusters,
    %   epoch the number of iterations,
    %   xdim and ydim are the dimensions to be plotted, default xdim=1,ydim=2

    error(nargchk(3, 5, nargin));  % check the number of input arguments
    if (nargin<4)
        xdim=1; ydim=2;   % default plot values
    end

    [dlen,dim] = size(Data);

    %prototypes =  % small initial values
    % % or
    sbrace = @(x,y)(x{y});
    fromfile = @(x)(sbrace(struct2cell(load(x)),1));
    prototypes=fromfile('clusterCentroids.mat');

    lambda0 = n/2; %initial neighborhood value
    % lambda
    lambda = lambda0 * (0.01/lambda0).^([0:(epochs-1)]/epochs);
    % note: the lecture slides refer to this parameter as sigma^2
    %       instead of lambda

    for i=1:epochs
        D_prototypes = zeros(n,dim);   % difference for vectors is initially zero
        D_prototypes_av = zeros(n,1);       % the same holds for the quotients

        for j=1:dlen  % consider all points at once for the batch update

            % sample vector
            x = Data(j,:); % sample vector
            X = x(ones(n,1),:);  % we'll need this

            % neighborhood ranking
            % DISTANCE!!!
            % 1-BMU, 2-BMU, etc. (hint:sort)
            % [Distances Indices Ranks]
            dist = sortrows([pdist2(x, prototypes); 1:n]');

            %find ranking,h,H
            dist = sortrows([dist [1:n]'],2);
            
            % accumulate update
            D_prototypes = D_prototypes + (exp(-dist(:,3)/lambda(i))*x);
            D_prototypes_av = D_prototypes_av + exp(-dist(:,3)/lambda(i));
        end
        D_prototypes = D_prototypes ./ [D_prototypes_av D_prototypes_av];
        
        % update
        prototypes = D_prototypes;
        
        % track and plot
        if ismember(i,[20, 100, 200, 500])
            L = L + 1;
            subplot(4,1,L);
            plot(Data(:,xdim),Data(:,ydim),'bo','markersize',3);
            hold on
            plot(prototypes(:,xdim),prototypes(:,ydim),'r.','markersize',10,'linewidth',3);
            voronoi(prototypes(:,xdim),prototypes(:,ydim));
            title(['epochs = ', num2str(i)]);
            fprintf(1,'%d / %d \r',i,epochs);
            hold off
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
