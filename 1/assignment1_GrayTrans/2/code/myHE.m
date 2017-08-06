function [ new_img ] = myHE( img )
%%Does Histogram Equalisation
[m n p] = size(img);
new_img = zeros(size(img));
for i=1:p,
    img_vector = img(:, :, i);
    img_vector = img_vector(:);
    m_hist = imhist(img_vector, 256);
    c_hist = cumsum(m_hist)/sum(m_hist);
    new_img(:, :, i) = reshape(c_hist(img_vector+1), m, n);
end
end

