function [new_img] = myBilinearInterpolation(iimg)
    img = double(iimg);
    [m n] = size(img);
    index_rows = 1:3:(3*m-2);
    index_cols = 1:2:(2*n-1);
    new_img = zeros(3*m - 2, 2*n - 1);
    new_img(index_rows, index_cols) = img;
    % for rows
    new_img(index_rows, 2:2:(2*n-1)) = (img(:,1:(n-1)) + img(:, 2:n)) / 2.0 ;
    % for cols
    index_rows_new = index_rows(1:((size(index_rows, 2)-1)));
    new_img(index_rows_new+1, :) = (2*new_img(index_rows_new, :) + new_img(index_rows_new+3, :)) / 3.0;
    new_img(index_rows_new+2, :) = (new_img(index_rows_new, :) + 2*new_img(index_rows_new+3, :)) / 3.0;
end