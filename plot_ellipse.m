% This function will plot an ellipsoid associated with a 2D Gaussian distribution
% The ellipsoid is centered at mu
% The ellipsoid contains all points within one standard deviation of mu

% INPUTS:
% mu : The 2-dimensional mean vector of the distribution
% Sig : The 2x2 covariance matrix of the distribution

function plot_ellipse(mu,Sig)

for i = 1:101

	v = [cos(6.28*i/100) ; sin(6.28*i/100)];
	z(:,i) = mu + Sig*v;
	
end

hold on
plot(z(1,:),z(2,:),'r')
plot(mu(1),mu(2),'or')
hold off