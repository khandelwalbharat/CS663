function [U, S, V] = mySVD(A)
    % U is an normalized eigenvector matrix of A*A'
    B=A*A';
    [U, D]=eig(B);
    % Taking the eigenvalues in decreasing order and changing the respective
    % eigenvectors position
    [~,I] = sort(diag(D),'descend');
    U=U(:,I);

    % V is a normalized eigenvector matrix of A*A'
    B=A'*A;
    [V,D]=eig(B);
    % Taking the eigenvalues in decreasing order and changing the respective
    % eigenvectors position
    % The nonzero eigenvalues would be same here as in previous case as
    % eigenvalues of A*A' and A'*A are same.
    [~,I] = sort(diag(D),'descend');
    V=V(:,I);

    % A=U*S*V' or U'*A*V=U'*U*S*V'*V = S. 
    X=U'*A*V;
    [m,n]=size(X);

    for i=1:1:min(m,n)
    % Now here eigenvectors can differ by a factor of -1. This is because if u
    % is an eigenvector then -u is also an eigenvector. Hence as in SVD, we
    % take only positive values in the diagonal thus we can multiply columns of
    % either U or V corresponding to a negative value in U'*A*V.
        if(X(i,i)<0)
            U(:,i)=-U(:,i);
        end 
    end
    S = abs(X);
end

