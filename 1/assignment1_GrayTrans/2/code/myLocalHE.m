function [ val ] = myLocalHE( img )
%%  myLocalHE -> Takes an odd number square matrix and calculates local hist. equalization
%   Removal of ones has to be done here
    [m n] = size(img);
    center_intensity = img((m+1)/2, (n+1)/2);
    m_hist = imhist(uint8(img), 256);
    c_hist = cumsum(m_hist)/sum(m_hist);
    val = c_hist(center_intensity+1);
end

