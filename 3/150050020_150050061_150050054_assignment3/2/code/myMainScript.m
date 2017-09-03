%% MyMainScript
% sample for my own colormap
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

% This contains the code that imports the image,
% generates the plots, and segments it
tic;
%% Your code here
image = double(imread('../data/baboonColor.png'));
[img, features, segmented_img] = myMeanShiftSegmentation(image, 2, 1, 870, 270, 150, 20, 0.08);

figure();
imagesc(image);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;
title('Original Image');

figure();
imagesc(segmented_img);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;
title('Segmented Image');

toc;
