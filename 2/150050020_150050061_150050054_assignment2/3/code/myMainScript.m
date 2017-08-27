%% MyMainScript

tic;
%% Image Sharpening
    img1 = load('../data/barbara.mat');
    img1 = img1.imageOrig;
    myPatchBasedFiltering(img1);
toc;
