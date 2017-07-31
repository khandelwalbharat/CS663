%% MyMainScript

% code for colormap -> Used the code given in the assignment document
myNumOfColors = 256; 
colorScale = 0:1/(myNumOfColors-1):1;
myColorScale = [ colorScale' colorScale' colorScale' ];

%% Your code here
img1 = imread('../data/barbara.png');
img2 = imread('../data/TEM.png');
img3 = imread('../data/canyon.png');

%% myHE
tic;
myHE1 = myHE(img1);
imagesc(img1), colormap(myColorScale), colorbar;
figure, imagesc(myHE1), colormap(myColorScale), colorbar;
toc;


