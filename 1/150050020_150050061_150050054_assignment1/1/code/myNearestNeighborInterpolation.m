function [ new_img ] = myNearestNeighborInterpolation( img )
%% Enlarges the image by using nearest neighbour interpolation
    [m n] = size(img);
    index_rows = 1:3:(3*m-2);
    index_cols = 1:2:(2*n-1);
    index_cols_trimmed = index_cols(1:(size(index_cols, 2)-1));
    index_rows_trimmed = index_rows(1:(size(index_rows, 2)-1));
    
    new_img = zeros(3*m - 2, 2*n - 1);
    new_img(index_rows, index_cols) = img;
    
    % copy the left portion for rows
    new_img(index_rows_trimmed+1, :) = new_img(index_rows_trimmed, :);
    new_img(index_rows_trimmed+2, :) = new_img(index_rows(2:size(index_rows,2)), :);
    new_img(:, index_cols_trimmed+1) = new_img(:, index_cols_trimmed);

end

