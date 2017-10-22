%% MyMainScript
tic;
%% Your code here
clc;
clear;
imgPath = '../../images/att_faces/';
[training_set, testing_set] = getImages(imgPath);
newImages = getOtherImages(imgPath);
threshold = 0.023;

% training here
[x_bar, X, V] = eigenfaces(training_set);
k = 23;
V_hat = V(:, 1:k);
alpha = V_hat'*X;
alpha_size = size(alpha,2);

z = testing_set-repmat(x_bar, [1, size(testing_set,2)]);
b = V_hat'*z;

neg_z = newImages - repmat(x_bar, [1, size(newImages,2)]);
neg_b = V_hat'*neg_z;

% pos = zeros(size(b, 2), 1);
maxp = zeros(size(b, 2), 1);

false_negs = 0;
for i=1:size(b, 2),
    dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
    prob = 1./dist;
%     prob = sort(prob/sum(prob), 'descend');
%     ratio = prob(1) + prob(2);
%     pos(i) = ratio;
%     maxp(i) = prob(1);
    maxp(i) = max(prob);
    if(maxp(i) < threshold)
        false_negs = false_negs + 1;
    end
end

% pos = sort(pos);
% maxp = sort(maxp);

% neg_pos = zeros(size(neg_b, 2), 1);
maxnp = zeros(size(neg_b, 2), 1);


false_pos = 0;
for i=1:size(neg_b, 2),
	dist = sum((alpha - repmat(neg_b(:,i),[1,alpha_size])).^2, 1);
    prob = 1./dist;
%     prob = sort(prob/sum(prob), 'descend');
%     ratio = prob(1) + prob(2);
%     neg_pos(i) = ratio;
%     maxnp(i) = prob(1);
    maxnp(i) = max(prob);
    if(maxnp(i)>=threshold) 
        false_pos = false_pos + 1;
    end
end

fprintf('Number of false positives is %d\n', false_pos);
fprintf('Number of false negatives is %d\n', false_negs);
% neg_pos = sort(neg_pos, 'descend');
% maxnp = sort(maxnp, 'descend');

toc;