function [ new_img ] = myAHE(img, K)
%% myAHE : Does adaptive histogram equalization 
%  Does on a window of size (2k+1)*(2k+1)
[m n p] = size(img);
new_img = zeros(size(img));
for ii=1:p,
    % using a for loop here because number of channels are usually small (1
    % or 3 or so on)
    % new_img(:, :, i) = nlfilter(img(:, :, i), [2*K+1 2*K+1], @myLocalHE);
    parfor i=1:m,
       for j=1:n,
            v = img(max(1, i-K):min(m, i+K), max(1, j-K):min(n, j+K) );
            m_hist = imhist(v, 256);
            c_hist = cumsum(m_hist)/sum(m_hist);
            new_img(i, j, ii) = c_hist(img(i, j, ii)+1);
       end
    end
end

end

