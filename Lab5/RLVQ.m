function [outputLabels,errorValList, prototypes, prototypeLabels] = RLVQ(training, labels, test, numProt, maxEpoch)
    prototypes = [];
    prototypeLabels = [];
    errorVal = 0;
    errorValList = [];

    % Determine number of labels
    numLabels = max(labels);
    % Initialize prototypes
    for i = 1:numProt
        % Determine label of this prototype
        currentLabel = mod(i, numLabels) + 1;
        prototypeLabels = [prototypeLabels; currentLabel];
        meanOfLabel = mean(training(labels == currentLabel));
        % Place randomly near mean
        newPos = meanOfLabel + (rand([1 2]) - 0.5 .* (1/10 * meanOfLabel));
        prototypes = [prototypes; newPos];
    end
    
    % Initialize relevances
    relevances = [0.5, 0.5];
    
    % Start training
    for i=1:maxEpoch
        misclassified = 0; 
        % Loop over points
        for j=1:size(training, 1)
            % Initialize minimal distance
            minDist = inf(1);
            currentPoint = training(j,:);
            % Loop over prototypes to find the closest prototype
            for k=1:numProt
                currentProt = prototypes(k,:);
                dist = pdist([currentPoint;currentProt],'euclidean');
                if dist < minDist
                    minDist = dist; minProt = k;
                end
            end
            % Calculate prototype movement in both directions
            xShift = 0.01*(training(j,1)-prototypes(minProt,1));
            yShift = 0.01*(training(j,2)-prototypes(minProt,2));

            % Move prototypes (attraction/repulsion)
            if prototypeLabels(minProt) == labels(j)
               prototypes(minProt,1) =  prototypes(minProt,1) + xShift;
               prototypes(minProt,2) =  prototypes(minProt,2) + yShift;
            else
               prototypes(minProt,1) =  prototypes(minProt,1) - xShift;
               prototypes(minProt,2) =  prototypes(minProt,2) - yShift;
            end
        end

        % Count misclassified points
        for j=1:size(training,1)
            currentPoint = training(j,:);
            protDist = inf(1);
            for k=1:numProt
                currentProt = prototypes(k,:);
                dist = pdist([currentPoint;currentProt],'euclidean'); 
                if dist < protDist
                   protDist = dist;
                   prot = k;

                end
            end
            if prototypeLabels(prot) ~= labels(j)
               misclassified = misclassified + 1;
            end
        end

        % Add errorVal to list
        errorValList = [errorValList, (misclassified / length(training))];
        
        % Calculate error and break if error is constant for 10 iterations
        if abs(errorVal - misclassified / length(training)) < 0.01
            sameCount = sameCount + 1;
            if sameCount == 10
                break;
            end
        else
            errorVal = misclassified / length(training);
            sameCount = 0;
        end
    end

    % Start classifying
    outputLabels = [];
    for i=1:length(test)
        minDist = inf(1);
        currentPoint = test(i,:);
        for j=1:numProt
            currentProt = prototypes(j,:);
            dist = pdist([currentPoint;currentProt],'euclidean');
            if dist < minDist
                minDist = dist;
                label = prototypeLabels(j);
            end
        end
        outputLabels = [outputLabels, label];
    end
end