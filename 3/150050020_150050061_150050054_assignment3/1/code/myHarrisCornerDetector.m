function [ smooth_img, Ix, Iy, eig1, eig2, C ] = myHarrisCornerDetector( imageOrig, sigma_smooth, sigma_region, k )
% Gives Harris corner detection
% get the values of K
K_smooth = round(3*sigma_smooth);
K_region = round(3*sigma_region);
smooth_filt = fspecial('gaussian', [2*K_smooth+1 2*K_smooth+1], sigma_smooth);
region_filt = fspecial('gaussian', [2*K_region+1 2*K_region+1], sigma_region);

% build the matrix for gradient
% this works well with imfilter (which is cross correlation basically)
gradVector = -1:1;

minIntensity = min(imageOrig(:));
maxIntensity = max(imageOrig(:));
img = (imageOrig - minIntensity)/(maxIntensity - minIntensity);

% smoothen the image
smooth_img = imfilter(img, smooth_filt);

% find x and y gradients ( assuming x is horizontal)
Ix = imfilter(smooth_img, gradVector);
Iy = imfilter(smooth_img, gradVector');

% generate the matrices for structure tensor ( w*Ix2, w*Iy2, w*ix*Iy )
wIx2  = imfilter(Ix.^2, region_filt);
wIy2  = imfilter(Iy.^2, region_filt);
wIxIy = imfilter(Ix.*Iy, region_filt);

% finding the eigenvalues in bulk ( with a bit of math )
eig1 = (wIx2 + wIy2)/2;
eig2 = sqrt((wIx2 - wIy2).^2 + 4*(wIxIy.^2))/2;

eig1 = eig1 + eig2;
eig2 = eig1 - 2*eig2;

% det - k*(trace).^2
C = (wIx2.*wIy2 - wIxIy.^2) - k*((wIx2 + wIy2).^2);

end

