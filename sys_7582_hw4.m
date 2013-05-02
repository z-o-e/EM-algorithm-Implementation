% sys_7582_hw4
% EM algorithm implementation on 2-D 2-component Gaussian Mixture Model 

% load data
load('sys_7582_hw4.mat')m, 

% initial guesses for the parameteres
p=0.5;
mu_1=[mean(X(1,:))+0.5 mean(X(2,:))+0.5 ]';
mu_2=[mean(X(1,:))-0.5 mean(X(2,:))-0.5 ]';
sig_1=[1 0; 0 1];
sig_2=[1 0; 0 1];


% threshold, number of points and counter
eps=1e-3;
error_1=eps;
error_2=eps;
difference=eps;
N=size(X,2);
count=0;

% start iterations
while( error_1>=eps && error_2>=eps && count<500)
    % E-Step:
    % compute the normalize factor
    denominator= p*normcdf( X,N,mu_1,sig_1 )+ (1-p)*normcdf( X,N,mu_2,sig_2 );
    % compute responsibilities for the two classes 
    q1=p*normcdf( X,N,mu_1,sig_1 )./denominator;
    q0=(1-p)*normcdf( X,N,mu_2,sig_2 )./denominator;
    
    
    % M-Step:
    % update the weighted means and variances, and p
    mu_1=[q1*X(1,:)'  q1*X(2,:)']'/sum(q1);
    mu_2=[q0*X(1,:)'  q0*X(2,:)']'/sum(q0);
    
    sig_1=zeros(2,2);
    sig_2=zeros(2,2);
    for i=1:N
        sig_1=sig_1+q1(i).*(X(:,i)-mu_1)*(X(:,i)-mu_1)';
        sig_2=sig_2+q0(i).*(X(:,i)-mu_2)*(X(:,i)-mu_2)';
    end
    sig_1=sig_1/sum(q1);
    sig_2=sig_2/sum(q0);
    
    p=sum(q1)/N;
    
    % calculate the the average mean square error
    msqr_error_1=zeros(1,N);
    msqr_error_2=zeros(1,N);
    for i=1:N
        msqr_error_1(i)=sqrt((X(:,i)-mu_1)'*(X(:,i)-mu_1));
        msqr_error_2(i)=sqrt((X(:,i)-mu_2)'*(X(:,i)-mu_2));
    end
    error_1=norm(msqr_error_1)/N;
    error_2=norm(msqr_error_2)/N;
    
    % inrement the counter
    count=count+1;
   
end


% print parameter estimation results
disp('mean for the first Gaussian mu_1 is:')
mu_1

disp('mean for the second Gaussian mu_2 is:')
mu_2

disp('covariance for the first Gaussian sig_1 is:')
sig_1

disp('covariance for the second Gaussian sig_2 is:')
sig_2

disp('the probablistic parameter p is:')
p


% plot data points and ellipsoid based on parameter estimation results
scatterplot(X')
axis([-4 10 -2 8])
plot_ellipse(mu_2,sig_2)
plot_ellipse(mu_1,sig_1)
