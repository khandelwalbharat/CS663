%% MyMainScript

tic;
%% Image Sharpening
img1 = load('../data/superMoonCrop.mat');
img2 = load('../data/lionCrop.mat');
img1 = img1.imageOrig;
img2 = img2.imageOrig;

% window size used is 25x25
% scale is 2
% sigma for the gaussian applied is 5
myUnsharpMasking(img1);
myUnsharpMasking(img2);
toc;
