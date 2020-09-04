function [assignment,means, meanArray, error] = kmeans(data, k, plusplus)
    [rows, columns] = size(data);
    oldAssignment = zeros(rows,1);
    stop = false;
    
    if (plusplus)
        % Initialize means using kmeans++
        means = zeros(k, 2);
        % Assign the first mean
        means(1,:) = data(randi(rows), :);
        % Skip first mean...
        for i=2:k
            % For every mean
            distances = pdist2(data, means(1:i-1, :), 'squaredeuclidean');
            plusplusDist = min(distances, [], 2);

            % Weighted random sample
            means(i,:) = data(randsample(rows, 1, true, plusplusDist), :);
        end
    else
        % Initialize means randomly
        means = data(randi(rows,[1,k]),:);
    end

    meanArray = means;
    
    while stop == false
        % Classify all datapoints
        distances = pdist2(data, means, 'squaredeuclidean');
        [~, assignment] = min(distances, [], 2);

        if assignment == oldAssignment
            stop = true; 
        else
            oldAssignment = assignment;
        end

        numPoints = zeros(k,1);

        % Add all assigned points to means
        for i=1:length(assignment)
            means(assignment(i),:) = means(assignment(i),:) + data(i,:);
            numPoints(assignment(i),1) = numPoints(assignment(i),1) + 1;
        end

        % Calculate the mean if nodes are assigned else randomly move mean
        for i=1:k
            if numPoints(i) ~= 0
                means(i,:) = means(i,:) / numPoints(i);
            else
                means(i,:) = data(randi(rows),:);
            end
        end
        meanArray = cat(3,meanArray,means);
    end
    
    % Calculate quantization error
    meanDist = zeros(k,1);
    for i=1:length(assignment)
        currMean = means(assignment(i),:);
        currPoint = data(i,:);
        meanDist(assignment(i)) = meanDist(assignment(i)) + pdist([currMean; currPoint], 'squaredeuclidean');
    end
    error = 0.5 * sum(meanDist);
end

