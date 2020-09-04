subplot(2,2,1);
% Plot first class
scatter(x1(classes == 1), x2(classes == 1), 150, 'b')
% Plot second class.
hold on;
scatter(x1(classes == 2), x2(classes == 2), 120, 'r')

subplot(2,2,2); 
plot(x,y2)

subplot(2,2,3);
plot(x,y2)

subplot(2,2,4); 
plot(x,y2)

