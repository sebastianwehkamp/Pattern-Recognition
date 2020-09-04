function [] = exercise1(matrix, vector)
    %[dist1, dist2] = plotNormPDF();
    %question1()
    %question2()
    %question7(matrix, vector)
    createPlot();
end

function [dist1, dist2] = plotNormPDF()
    x = -5:.1:15;
    dist1 = normpdf(x, 5, 2);
    dist2 = normpdf(x, 7, 2);
    hold on
    plot(x, dist1);
    plot(x, dist2);
    legend('dist1', 'dist2', 'overlapping area');
    
    % intersection (0.0001 should do unless your sigmas are very large)
    ind = dist1 .* dist2 > 0.000001;
    % Find the minimum values in range
    minVals = min([dist1(ind); dist2(ind)]);

    %if ~isempty(minVals)
    %    area(x(ind), minVals)
    %end
    hold off
end

function [prob] = question1()
    x = [30 10];
    value = normcdf(x, 7, 2);
    prob = value(1) - value(2);
end

function [prob] = question2()
    x = [30 10];
    value = normcdf(x, 5, 2);
    prob = value(1) - value(2);
end

function [occurences] = question7(matrix, vector)
    occurences = 0;
    for row = 1:length(matrix)
        rowdata = matrix(row, :);
        occurences = occurences + isequal(rowdata, vector);
    end
end

function [] = createPlot()
x = [0 0.0450 1];
y = [0 0.4400 1];
ind0 = 1:3; xi_end = NaN; yi_end= NaN;  
for i = 1:numel(y)/numel(ind0)
  ind = ind0 + 5*(i-1);
  yi = linspace(y(ind(1)), y(ind(end)));
  xi = interp1(y(ind), x(ind), yi, 'spline');
  plot([xi_end xi], [yi_end yi])
  hold on
  xi_end = xi(end);
  yi_end = yi(end);
end

end