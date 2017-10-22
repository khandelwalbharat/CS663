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
[img, features, segmented_img] = myMeanShiftSegmentation(image, 2, 1, 1500, 250, 250, 15, 0.1);
figure;
subplot(1,2,1);
imagesc(image/255);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
title('Original');

subplot(1,2,2);
imagesc(segmented_img);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
title('Segmented');

toc;
