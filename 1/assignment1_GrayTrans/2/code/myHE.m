function [ new_img ] = myHE( img )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[m n] = size(img);
img_vector = img(:);
m_hist = imhist(img, 256);
c_hist = 255*cumsum(m_hist)/sum(m_hist);
new_img = reshape(c_hist(img_vector+1), m, n);
end

