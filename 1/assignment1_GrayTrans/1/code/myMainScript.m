%% MyMainScript

% code for colormap -> Used the code given in the assignment document
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ]; 

% assuming all images are in grayscale
%% Shrinking image
tic;
img_1 = imread('../data/circles_concentric.png');
D = 2;
new_img_D2 = myShrinkImageByFactorD(img_1, 2);
new_img_D3 = myShrinkImageByFactorD(img_1, 3);
imagesc(new_img_D2);
colormap (myColorScale);  
title('D = 2');
colorbar;

figure();
imagesc(new_img_D3);
title('D = 3');
colormap (myColorScale);  
colorbar;
toc;

%% Debug this : Enlarging image
tic;
img_2 = imread('../data/barbaraSmall.png');
new_img_2 = myBilinearInterpolation(img_2);
figure();
imagesc(new_img_2);
colormap (myColorScale);  
colorbar;
toc;

%% nearest nbr
tic;
img_3 = imread('../data/barbaraSmall.png');
new_img_3 = myNearestNeighborInterpolation(img_3);
figure();
imagesc(new_img_3);
colormap (myColorScale);  
colorbar;
toc;

