function cdf = normcdf( X,N,mu,sigma )
%   normcdf return the cdf of a normal distribution given its paramertes
%   and input

%   INPUT: X --- a matrix of points to calculate the cdf
%          N --- number of points in X
%          mu --- mean of the normal distribution
%          sigma --- standard deviation of the normal distribution

%   OUTPUT: cdf --- value of the cdf

difference=zeros(2,N);
cdf=zeros(1,N);
for i=1:N
    difference(:,i)=X(:,i)-mu;
    cdf(i)=1/(2*pi*sqrt(norm(sigma)))*exp(-1/2*difference(:,i)'/sigma*difference(:,i));
end

end

