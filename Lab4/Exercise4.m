% Read image
image = imread('HeadTool0002.dib.bmp');
% Convert to double precission
image = im2double(image);
% Convert to gray scale
image = rgb2gray(image);
% Apply adaptive histogram eq
image = adapthisteq(image);
% Find 6 circles and show them
imshow(image);
[centers, radii, metric] = imfindcircles(image,[20 40], 'Sensitivity', 0.9);
centersStrong6 = centers(1:6,:);
radiiStrong6 = radii(1:6);
metricStrong6 = metric(1:6);
viscircles(centersStrong6, radiiStrong6,'EdgeColor', 'b');

figure;

% Find 2 circles and show them
imshow(image);
[centers, radii, metric] = imfindcircles(image,[20 40], 'Sensitivity', 0.9);
centersStrong2 = centers(1:2,:);
radiiStrong2 = radii(1:2);
metricStrong2 = metric(1:2);
viscircles(centersStrong2, radiiStrong2,'EdgeColor', 'b');