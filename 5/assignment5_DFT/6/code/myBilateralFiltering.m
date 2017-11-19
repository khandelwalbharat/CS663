function [ output_image, spatial_kernel ] = myBilateralFiltering( image, sigma_space, sigma_intensity )
%% myBilateralFiltering: my own Bilateral filtering
    [m, n, p] = size(image);
    % 2K+1 is the size of the kernel
    minK = min(3*round(sigma_space), 3*round(sigma_intensity));
    K = max(1, minK);
    padded_image = zeros(m+2*K, n+2*K, p);
    output_image = zeros(m,n,p);
    for ii=1:p,
        padded_image(K+1:K+m, K+1:K+n, ii) = image(:,:,ii);
    end
   
    spatial_kernel = fspecial('gaussian', 2*K+1, sigma_space);
    for ii=1:p,  % number of channels
        for i=1:m,
            for j=1:n,
                part_img = padded_image(i:i+2*K, j:j+2*K, ii);
                intensity_kernel = exp(-(part_img - image(i,j,ii)).^2/(2*sigma_intensity*sigma_intensity));
                r1 = intensity_kernel.*spatial_kernel;
                output_image(i,j,ii) = sum(sum(r1.*part_img))/sum(sum(r1));
            end
        end
    end     
end

