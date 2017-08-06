function [ new_img ] = myLinearContrastStretching( img )
%% Does Linear Contrast Stretching
    [m n p] = size(img);
%     new_img = zeros(size(img));
for i=1:p
    %finding the minimum and the maximum values and then interpolating
    min_val = min(min(img(:, :, i)));
    max_val = max(max(img(:, :, i)));

    new_img(:,:,i) = (img(:,:,i) - min_val).*(255/(max_val - min_val));
end
end


