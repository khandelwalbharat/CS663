function [ x_bar, X , V] = eigenfaces( training_set )
%EIGENFACES Summary of this function goes here
%   Detailed explanation goes here
    x_bar = mean(training_set, 2);
    X = training_set - repmat(x_bar, [1, size(training_set,2)]);
    L = X'*X;
    [U, D] = eig(L);
    V = X*U;
    V = normc(V);
    
    %Get the most significant eigenvectors at the beginning
    [temp, perm] = sort(diag(D), 'descend');
    D = D(perm, perm);
    V = V(:, perm);
end

