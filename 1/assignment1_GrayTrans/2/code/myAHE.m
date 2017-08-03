function [ new_img ] = myAHE(img, K)
%% myAHE : Does adaptive histogram equalization 
%  Does on a window of size (2k+1)*(2k+1)
[m n p] = size(img);
new_img = zeros(size(img));
for i=1:p,
    % using a for loop here because number of channels are usually small (1
    % or 3 or so on)
    new_img(:, :, i) = nlfilter(img(:, :, i), [2*K+1 2*K+1], @myLocalHE);
end

end

