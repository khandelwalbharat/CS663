function [ train_set_yale, test_set_yale ] = getImagesYale( imgPathYale )
%GETIMAGESYALE Summary of this function goes here
%   Detailed explanation goes here
    train_set_yale = [];
    test_set_yale = [];
    for i = 1:39
        if(i<10)
            folder = strcat(imgPathYale, 'yaleB', '0', num2str(i),'/');
        elseif(i==14)
            continue;
        else
            folder = strcat(imgPathYale, 'yaleB', num2str(i),'/');
            allFiles = dir( folder );
            allNames = { allFiles.name };
        for j = 1:60  
            file = strcat(folder, allNames{j+2});
            img = imread(file);
            img = double(img)/255;
            if(j<=40)
                train_set_yale = [train_set_yale, img(:)];
            else
                test_set_yale = [test_set_yale, img(:)];
            end
        end
    end

end

