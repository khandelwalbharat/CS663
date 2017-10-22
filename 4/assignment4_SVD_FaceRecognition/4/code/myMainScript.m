%% Main Script to test SVD
A = reshape(1:36, 9, 4);

[U, S, V] = mySVD(A);
[Uo, So, Vo] = svd(A);

disp(U*S*V');
disp(Uo*So*Vo');
