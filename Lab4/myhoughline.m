function [] = myhoughline(image, theta, rho)
    % Convert to cartesian coords
    [x1, y1] = pol2cart(degtorad(theta),rho);
    X = [0, x1];
    Y = [0,y1];
    % Show original image with line
    imshow(image);
    line(X,Y);
    % Special case for vertical lines
    if theta == 0
        line([x1,x1],[y1-1000,y1+1000]);
    else 
        % Compute formula of orthogonal line
        m = (diff(Y)/diff(X));
        a = -1/m;
        b = y1-a*x1;
        x = linspace(-1000,1000)';
        y = a*x+b;
        % Plot orthogonal line
        line(x,y);
    end
end