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
[img, Ix, Iy, eig1, eig2, C] = myHarrisCornerDetector(imageOrig, 1.3, 17.6, 0.095);


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
color_img = zeros(m, n, 3);
for i=1:3,
    color_img(:,:,i) = img;
end

C = (C>0);
C = imfilter(C, ones(5));

tmp = color_img(:,:,1);
tmp(C) = 1;
color_img(:,:,1) = tmp;

tmp = color_img(:,:,2);
tmp(C) = 0;
color_img(:,:,2) = tmp;

tmp = color_img(:,:,3);
tmp(C) = 0;
color_img(:,:,3) = tmp;


figure();
imagesc(color_img);
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