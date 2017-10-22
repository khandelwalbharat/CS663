%% Main script for Question 2
tic;
[train, test] = getImagesYale('../../images/CroppedYale/');
test_img = test(:,1); % test image for reconstruction

% training phase
[x_bar, X, V] = eigenfaces(train);
k = [2, 10, 20, 50, 75, 100, 125, 150, 175];

% plot
for i=1:size(k,2)
    % take eigenfaces
    V_hat = V(:, 1:k(i));
    test_img_mean = test_img - x_bar;
    test_b = V_hat'*test_img_mean;
    
    % reconstruct
    z_re = x_bar + V_hat*test_b;
    img = reshape(z_re, 192, 168);
    
    % plot it
    subplot(3, 3, i);
    imshow(img);
    title(['Reconstructed at k = ' num2str(k(i))]);
end

figure;
for i=1:25,
    eig_face = reshape(V(:, i), 192, 168);
    subplot(5,5,i);
    imagesc(eig_face);
    colormap('gray');
    title(['Eigenface #' num2str(i)]);
end

toc;