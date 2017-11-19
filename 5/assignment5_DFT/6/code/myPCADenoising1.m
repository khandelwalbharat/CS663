function [img_denoised] = myPCADenoising1(im_noisy, sigma, p)
% Denoise the noisy using global PCA, and means averaging
    [m, n] = size(im_noisy);
    N = (m-p+1)*(n-p+1);

    % generate the array of patches
    P = zeros(p*p, N);
    for i=1:p*p,
        part_img = im_noisy(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p));
    %     fprintf('Took patch from ( %d, %d ) to ( %d, %d )\n', (1+mod(i-1, p)), (1+floor((i-1)/p)), m-p+1+mod(i-1, p), n-p+1+floor((i-1)/p)); 
        P(i, :) = part_img(:);
    end

    % We have the values of P here
    [V, D] = eig(P*P');
    alph = V'*P;

    alph_mean = repmat(max(0, mean(alph.^2, 2) - sigma.^2), 1, N);
    alph_denoised = alph.*(1./(1 + sigma*sigma./alph_mean));
    P_new = V*alph_denoised; 

    % get the denoised image
    % to take average
    im2 = zeros(size(im_noisy));
    cnt = zeros(size(im_noisy));
    for i=1:p*p,
         im2(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p)) = reshape(P_new(i,:), m-p+1, n-p+1) +  im2(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p));
         cnt(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p)) = 1 + cnt(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p));
    end
    img_denoised = im2./cnt;
end