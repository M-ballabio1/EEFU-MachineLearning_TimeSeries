function [A,B,C,D,Mean0,Cov0,StateType] = tVarPar(params,x,alpha0,beta0)
% parameter mapping for model: dynamic regression with fixed intercept
%
% y(t) = alfa + beta(t) x(t) + D e(t)       Measurement equation
% alfa(t) = alfa(t-1)                       Transition equation 1 (constant intercept)
% beta(t) = beta(t-1) + B2 u(t)             Transition equation 2 (time-varying slope)
%
% A = [1 0 ; 0 1] = I2                                                  --> Identity matrix 2x2
% D = sqrt(exp(params(2)))                                              --> positive scalar
% C(t) = [1, x(t)]                                                      --> matrix nx2 (intercept + covariate)
% B = [intercept_variance , slope_variance] = [B1 , B2] = [0 , B2]      --> vector of 2 elements containing states variances = [0 , B2]
% params = [log(B2) , log(D)]                                           --> vector of 2 elements containing initial log-variances
% alpha0 = initial value for the intercept state-equation
% beta0 = initial value for the slope state-equation

%%% Transition matrix
A = eye(2);

%%% Var-covar matrix of state/transition equation
B = [0 , sqrt(exp(params(1)))];     % 0 and positive variance constraints
B = B(:);

%%% var-covar matrix of observations/measurement equation
D = sqrt(exp(params(2)));           % Positive variance constraints

%%% Number of observations
n = length(x);

%%% States initial values
Mean0 = [alpha0;beta0];     % Mean of the multivariate Normal distribution of the states
Cov0 = eye(2)*10^10;        % Var-covar matrix (diffuse values) of multivariate Normal distribution of the states

%%% State-space matrices
StateType = [];
% Transition matrix
A = repmat({A},n,1);
% Var-covar matrix of state/transition equation
B = repmat({B},n,1);
% Measurement matrix
C = num2cell([ones(n,1),x],2);
% var-covar matrix of observations/measurement equation
D = repmat({D},n,1);

end