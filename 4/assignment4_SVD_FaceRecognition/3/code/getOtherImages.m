function [testing_set] = getOtherImages( imgPath )
    testing_set = [];
    for i = 33:40,
        folder = strcat(imgPath, 's',num2str(i),'/');
        for j = 1:10,
            file = strcat(folder, num2str(j), '.pgm');
            img = imread(file);
            img = double(img)/255;
            testing_set = [testing_set, img(:)];
        end
    end
end
