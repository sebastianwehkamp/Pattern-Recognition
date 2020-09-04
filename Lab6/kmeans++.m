function [assignment, means, meanArray, error] = kmeans(data, k, plusplus)
    [rows, columns] = size(data);

    if (plusplus)
        % Initialize means using kmeans++
        means = zeros(k, 2);
        % Assign the first mean
        means(1) = data(rand(), :);
        % Skip first mean...
        for i=2:k
            % For every mean
            plusplusDist = zeros(rows, 1);
            for j=1:rows
                % For every point
                for h=1:i
                    % Calculate shortest distance to available means
                    currDist = pdist([data(j, :);means(h, :)], 'squaredeuclidian');
                    if (currDist < plusplusDist(j))
                        plusplusDist(j) = currDist;
                    end
                end
            end
            % Weighted random sample
            means(i) = data(randsample(n, 1, true, plusplusDist), :);
        end
    else
        % Initialize means randomly
        means = data(randi(rows,[1,k]),:);
    end

    oldAssignment = zeros(rows,1);
    stop = false;
    meanArray = means;
    
    while stop == false
        % Classify all datapoints
        assignment = [];
        for i=1:rows
            point = data(i,:);
            minDist = inf(1);
            for j=1:k
                mean = means(j,:);
                dist = pdist([point;mean]);
                if dist < minDist
                    minDist = dist;
                    closMean = j;
                end
            end
            assignment = [assignment; closMean];        
        end

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
    
    meanDist = zeros(k,1);
    % Calculate quantization error
    for i=1:length(assignment)
        currMean = means(assignment(i),:);
        currPoint = data(i,:);
        meanDist(assignment(i)) = meanDist(assignment(i)) + pdist([currMean; currPoint], 'squaredeuclidean');
    end
    error = 0.5 * sum(meanDist);
end