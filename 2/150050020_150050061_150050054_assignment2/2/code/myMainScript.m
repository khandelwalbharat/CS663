%% MyMainScript
% sample for my own colormap
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

% This contains the code that imports the image,
% generates the subplots, and computes the bilateral filtered image 
tic;
%% Your code here
% Load the image and generate noisy version (assume arbitrary number of
% channels)
% load the image and the parameters
load('../data/barbara.mat');
frac_intensity = 0.05;
spatial_sigma = 1.6;
intensity_sigma = 9.7;

% generate the noisy image 
[m n p] = size(imageOrig);
imageNoisy = imageOrig;
for i=1:p,
    intensity_range = max(max(imageOrig(:,:,i))) - min(min(imageOrig(:,:,i)));
    imageNoisy(:,:,i) = imageNoisy(: ,: ,i) + frac_intensity*intensity_range*randn(m, n);
end

% generate the bilateral filtered
fprintf('Please wait. This may take a few seconds...\n');
[imageBilateralFiltered, kernel] = myBilateralFiltering(imageNoisy, spatial_sigma, intensity_sigma);

% Printing the image
subplot(1,3,1);
imagesc(imageOrig);
title('Original image');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;

subplot(1,3,2);
imagesc(imageNoisy);
title('Noisy image');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;

subplot(1,3,3);
imagesc(imageBilateralFiltered);
title('Filtered image');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;

% Print the kernel after printing the images
figure();
imagesc(kernel);
title('Kernel');
daspect ([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;

fprintf('The RMSD value for the original and filtered image is %f\n', RMSD(imageOrig, imageBilateralFiltered));

%% Give a map of values to optimize the value of sigma values
%
% fprintf('Calculating values...\n');
% valmat = zeros(1000, 1000);
% for s=1:3:100,
%     for i=1:3:100,
%         A = myBilateralFiltering(imageNoisy, s/10, i/10);
%         k = RMSD(imageOrig, A);
%         fprintf('RMSD (sigma_i = %f, sigma_s = %f) = %d\n', i/10, s/10, k);
%         valmat(s,i) = k;
%     end
% end
%

%% Some commented code which gives the RMSD values for the neighbouring values
%
% Gives a map of values
% values figured out : 1.6, 9.7
% neighbouring values: 
% 3.291765 
% 3.294888 
% 3.313506 
% 3.302530 
% after one iteration
% im1 = myBilateralFiltering(imageNoisy, 0.9*spatial_sigma, intensity_sigma);
% im2 = myBilateralFiltering(imageNoisy, 1.1*spatial_sigma, intensity_sigma);
% im3 = myBilateralFiltering(imageNoisy, spatial_sigma, 0.9*intensity_sigma);
% im4 = myBilateralFiltering(imageNoisy, spatial_sigma, 1.1*intensity_sigma);
% fprintf('%f \n', RMSD(imageOrig, im1));
% fprintf('%f \n', RMSD(imageOrig, im2));
% fprintf('%f \n', RMSD(imageOrig, im3));
% fprintf('%f \n', RMSD(imageOrig, im4));
%
toc;
