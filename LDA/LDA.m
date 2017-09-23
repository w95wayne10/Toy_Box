function [NewComp, Coef, Eigval] = LDA(X, Y)
% Linear Discriminant Analysis
%
% notation and calculation base on 
% http://www.csd.uwo.ca/~olga/Courses/CS434a_541a/Lecture8.pdf
% p.23~p.25
%
% input:
%     X: n data with m columns.
%     Y: Labels for X.
%
% output:
%     NewComp: New representation of data.
%     Coef: Linear combination coefficients. (X*Coef=NewComp)
%     Eigval: degree of explaintion to data.

[n, ~] = size(X); % No need to know the number of column because reduced 
                  % dimensions depend on number of class. 

ClassLabel = unique(Y);
k = length(ClassLabel);

Mu = mean(X, 1);

S_W = zeros(n);
S_B = zeros(n);

for i = 1:k
    X_i = X(Y==ClassLabel(i), :);
    [n_i,~] = size(X_i);
    Mu_i = mean(X_i, 1);
    z = X_i-repmat(Mu_i,n_i, 1); % X_i-Mu_i
    S_i = z'*z;
    S_Btemp = n_i*((Mu_i-Mu)'*(Mu_i-Mu));
    S_W = S_W+S_i;
    S_B = S_B+S_Btemp;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% method 1:
% W = S_W\S_B;
% [Vector, Value] = eig(W);

% method 2:
[Vector, Value] = eig(S_B, S_W);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Eigval = diag(Value)';
Coef = Vector(:,1:k); 

NewComp = X*Coef;
end