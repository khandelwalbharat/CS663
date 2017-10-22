function [ x_bar, X , U ] = eigenfaces_svd( training_set )
%EIGENFACES_SVD Summary of this function goes here
%   Detailed explanation goes here
    x_bar = mean(training_set, 2);
    X = training_set - repmat(x_bar, [1, size(training_set,2)]);
    %U will be the eigenvector matrix of X'X [V S U]
    [V S U] = svd(X, 'econ');
    U = X*U;
    U=normc(U);
    [temp, perm] = sort(diag(S), 'descend');
    S = S(perm, perm);
    U = U(:, perm);
end

