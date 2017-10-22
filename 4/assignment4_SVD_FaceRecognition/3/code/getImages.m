function [training_set, testing_set] = getImages( imgPath )
%GETIMAGES To get the images matrix
%   Detailed explanation goes here
    training_set = [];
    testing_set = [];
    for i = 1:32
        folder = strcat(imgPath, 's',num2str(i),'/');
        for j = 1:10  
            file = strcat(folder, num2str(j), '.pgm');
            img = imread(file);
%             size(img)
            img = double(img)/255;
            if(j<=6)
                training_set = [training_set, img(:)];
            else
                testing_set = [testing_set, img(:)];
            end
        end
        
    end
end

