%% MyMainScript
tic;
% hyperparameters
sigma = 20; 
p = 7;
L = 200;
window = 31;

spatial_sigma = 1.6;
intensity_sigma = 9.7;

% Get image and make it noisy
im = double(imread('../data/barbara256.png'));
[m, n] = size(im);
im_noisy = im + sigma*randn(size(im));
im2 = myPCADenoising1(im_noisy, sigma, p);
toc;

tic;
im3 = myPCADenoising2(im_noisy, sigma, p, L, window);
toc;

tic;
im4 = myBilateralFiltering(im_noisy, spatial_sigma, intensity_sigma);
toc;

% Show all figures
figure; imagesc(im); colormap(gray); title('Real image');
figure; imagesc(im_noisy); colormap(gray); title('Noisy image');
figure; imagesc(im2); colormap(gray); title('Denoised image');
figure; imagesc(im3); colormap(gray); title('Denoised image using windows');
figure; imagesc(im4); colormap(gray); title('Denoised image using Bilateral filtering');

fprintf('MSE of original and global PCA denoised image = %f\n', sum(sum((im2 - im).^2))/m/n);
fprintf('MSE of original and windowed PCA denoised image = %f\n', sum(sum((im3 - im).^2))/m/n);
fprintf('MSE of original and bilateral filtering = %f\n', sum(sum((im4 - im).^2))/m/n);
