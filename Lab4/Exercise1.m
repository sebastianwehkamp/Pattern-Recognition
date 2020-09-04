function [tresholdedImg] = Exercise1(filename)
    % Read the image
    img = imread(filename);
    % Create edgemap
    map = edge(img,'canny');
    tresholdedImg = thresholdIm(map);
    localmaxima(map, 5);
    %plotHough(map);
end

function [] = plotHough(image)
    [H,T,R] = hough(image);
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal;
end

function [tresholdedImg] = thresholdIm(image)
    % Calculate Hough transform
    [H,theta,rho] = hough(image);
    % Plot the image with labeld axis
    imshow(H,[],'XData',theta,'YData',rho,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal;
    % Calculate the size
    [M,N] = size(H);
    % Calculate the peaks with threshold
    peaks = houghpeaks(H,M*N, 'Threshold', 0.999*max(H(:)))
    tresholdedImg = zeros(M,N);
    % Create new thresholded image
    tresholdedImg(peaks(:,1), peaks(:,2)) = H(peaks(:,1), peaks(:,2));    
end

function [] = localmaxima(image, numpeaks)
    [H,T,R] = hough(image);
    P = houghpeaks(H, numpeaks);
    imshow(H,[],'XData',T,'YData',R,'InitialMagnification','fit');
    xlabel('\theta'), ylabel('\rho');
    axis on, axis normal, hold on;
    plot(T(P(:,2)),R(P(:,1)),'s','color','white');
end

