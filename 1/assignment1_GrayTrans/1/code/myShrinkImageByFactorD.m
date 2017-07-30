function [ new_img ] = myShrinkImageByFactorD( img, D)
%%   my Shrink Image 
[m n] = size(img);
index_x = 1:D:m;
index_y = 1:D:n;
new_img = img(index_x, index_y);
end

