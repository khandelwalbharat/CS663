%% MyMainScript
% sample for my own colormap
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

% This contains the code that imports the image,
% generates the plots, and computes the corners
tic;
%% Your code here
load('../data/boat.mat');

% assume only grayscale images
[m n] = size(imageOrig);
[img, Ix, Iy, eig1, eig2, C] = myHarrisCornerDetector(imageOrig, 0.4, 20, 0.25);


% show the image
% imagesc(imageOrig);
% daspect([1 1 1]);
% axis tight;
% colormap(myColorScale);
% colorbar;

% figure();
imagesc(img);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;
% 
% figure();
% imagesc(Ix);
% daspect([1 1 1]);
% axis tight;
% colormap(myColorScale);
% colorbar;
% 
% figure();
% imagesc(Iy);
% daspect([1 1 1]);
% axis tight;
% colormap(myColorScale);
% colorbar;

figure();
imagesc(C);
daspect([1 1 1]);
axis tight;
colormap(myColorScale);
colorbar;

% figure();
% imagesc(eig2);
% daspect([1 1 1]);
% axis tight;
% colormap(myColorScale);
% colorbar;