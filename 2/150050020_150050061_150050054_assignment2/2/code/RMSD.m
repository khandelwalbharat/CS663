function [ val ] = RMSD( A, B )
%% RMSD : Finds the root mean squared difference
A1 = A(:);
A2 = B(:);
m = size(A1, 1);
val = sqrt(sum((A1-A2).^2)/m);
end

