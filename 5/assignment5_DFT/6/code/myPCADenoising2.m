function [ img_denoised ] = myPCADenoising2( im_noisy, sigma, p, L, W )
% Denoise using local PCA now
    [m, n] = size(im_noisy);
    N = (m-p+1)*(n-p+1);
    offset = (W-1)/2;
    p_ = (p-1)/2;

    % generate the array of patches
    P = zeros(p*p, N);
    for i=1:p*p,
        part_img = im_noisy(1+mod(i-1, p):m-p+1+mod(i-1, p), 1+floor((i-1)/p):n-p+1+floor((i-1)/p));
%         fprintf('Took patch from ( %d, %d ) to ( %d, %d )\n', (1+mod(i-1, p)), (1+floor((i-1)/p)), m-p+1+mod(i-1, p), n-p+1+floor((i-1)/p)); 
        P(i, :) = part_img(:);
    end

    % for each patch, take the closest ones and modify it
    P_new = zeros(size(P));
    for ii=1:size(P, 2),
        % Take the reference, and the 31 patches around it
        P_ref = P(:, ii);
        [i, j] = ind2sub([m-p+1, n-p+1], ii);
        x_index = (max(1, i-offset):min(i+offset, m-p+1))';
        y_index = (max(1, j-offset):min(j+offset, n-p+1))';
        index = zeros(size(x_index, 1), size(y_index, 1));
        
        % add x index and y index multiplied
        index = index + repmat(x_index, 1, size(y_index, 1)) + (m-p+1)*repmat(y_index'-1, size(x_index, 1), 1);
        
        % get local and then select nearest ones
        P_local = P(:, index(:));
        idx = knnsearch(P_local', P_ref', 'k', L);
        P_local = P_local(:, idx);

        % find eigenspace
        [V, D] = eig(P_local*P_local');
        alph_ref = V'*P_ref;
        alph = V'*P_local;
        alph_mean = max(0, mean(alph.^2, 2) - sigma.^2);
        alph_ref = alph_ref./(1 + sigma*sigma./alph_mean);
        P_new(:, ii) = V*alph_ref;
    end
    
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

