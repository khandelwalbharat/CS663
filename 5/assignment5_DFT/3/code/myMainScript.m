%% MyMainScript

tic;
%% Your code here
load('../data/image_low_frequency_noise.mat');
imagesc(Z);
title('Original image');
daspect([1 1 1]);
axis tight;
colormap('gray');

% calculate Fourier transform
F = fftshift(fft2(Z));
figure;
daspect([1 1 1]);
imagesc(log(abs(F)+1));
title('Log Fourier transform of the image');
axis tight;
colormap('jet');

% got this using impixelinfo
% and tuning k (box filter size
x = [119; 139];
y = [124; 134];
k = 3;

G = F(:,:);
for i=1:size(x,1),
    x1 = x(i); y1 = y(i);
    G(x1-k:x1+k, y1-k:y1+k) = 0;
end

figure;
daspect([1 1 1]);
imagesc(log(abs(G)+1));
title('Log Fourier transform after applying Notch filter');
axis tight;
colormap('jet');

Z1 = ifft2(ifftshift(G));
figure;
imagesc(abs(Z1));
title('Restored image');
daspect([1 1 1]);
axis tight;
colormap('gray');

toc;
