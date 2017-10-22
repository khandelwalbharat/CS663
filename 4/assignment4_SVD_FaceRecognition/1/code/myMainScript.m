%% MyMainScript

tic;
%% Your code here
clc;
clear;
imgPath = '../../images/att_faces/';
[training_set, testing_set] = getImages(imgPath);
toc;
tic;
[x_bar, X, V] = eigenfaces(training_set);
k = [1 2 3 5 10 15 20 30 50 75 100 150 170];
rate_plot = [];
for p=1:length(k)
    V_hat = V(:,1:k(p));
    alpha = V_hat'*X;
    alpha_size = size(alpha,2);

    z = testing_set-repmat(x_bar, [1, size(testing_set,2)]);
    b = V_hat'*z;

    images_matched = 0;
    for i=1:size(b,2)
        dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
        img_col = find(dist == min(dist));
        if( floor((i-1)/4) == floor((img_col-1)/6) )
            images_matched = images_matched + 1;
        end
    end
    rate_plot = [rate_plot 100.0*images_matched/size(testing_set,2)];
end
figure, plot(k, rate_plot);
xlabel('k');
ylabel('Recognition rate in %');
title('Recognition rates using eig (ORL dataset)');
toc;

tic;
    % Using svd function of matlab
[x_bar, X, V] = eigenfaces_svd(training_set);

rate_plot_svd = [];
for p=1:length(k)
    V_hat = V(:,1:k(p));
    alpha = V_hat'*X;
    alpha_size = size(alpha,2);
    
    z = testing_set-repmat(x_bar, [1, size(testing_set,2)]);
    b = V_hat'*z;
    
    images_matched = 0;
    for i=1:size(b,2)
        dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
        img_col = find(dist == min(dist));
        if( floor((i-1)/4) == floor((img_col-1)/6) )
            images_matched = images_matched + 1;
        end
    end
    rate_plot_svd = [rate_plot_svd images_matched/size(testing_set,2)];
end
figure, plot(k, 100.0*rate_plot_svd);
xlabel('k');
ylabel('Recognition rate in %');
title('Recognition rates using svd (ORL dataset)');
toc;

tic;
imgPathYale = '../../images/CroppedYale/';
[train_set_yale, test_set_yale] = getImagesYale(imgPathYale);
[x_bar, X, V] = eigenfaces_svd(train_set_yale);
toc;

tic;
rate_plot_svd_yale = [];
k_yale = [1 2 3 5 10 15 20 30 50 60 65 75 100 200 300 500 1000];
for p=1:length(k_yale)
    V_hat = V(:,1:k_yale(p));
    alpha = V_hat'*X;
    alpha_size = size(alpha,2);
    
    z = test_set_yale-repmat(x_bar, [1, size(test_set_yale,2)]);
    b = V_hat'*z;
    
    images_matched = 0;
    for i=1:size(b,2)
        dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
        img_col = find(dist == min(dist));
        if( floor((i-1)/20) == floor((img_col-1)/40) )
            images_matched = images_matched + 1;
        end
    end
    rate_plot_svd_yale = [rate_plot_svd_yale images_matched/size(test_set_yale,2)];
end
figure, plot(k_yale, 100.0*rate_plot_svd_yale);
xlabel('k');
ylabel('Recognition rate in %');
title('Recognition rates before removing top 3 eigenvalues (Yale dataset)');
toc;

tic;
rate_plot_svd_yale_exc = [];

for p=1:length(k_yale)
    V_hat = V(:,4:k_yale(p));
    alpha = V_hat'*X;
    alpha_size = size(alpha,2);
    
    z = test_set_yale-repmat(x_bar, [1, size(test_set_yale,2)]);
    b = V_hat'*z;
    
    images_matched = 0;
    for i=1:size(b,2)
        dist = sum((alpha - repmat(b(:,i),[1,alpha_size])).^2, 1);
        img_col = find(dist == min(dist));
        if( floor((i-1)/20) == floor((img_col-1)/40) )
            images_matched = images_matched + 1;
        end
    end
    rate_plot_svd_yale_exc = [rate_plot_svd_yale_exc images_matched/size(test_set_yale,2)];
end
figure, plot(k_yale, 100.0*rate_plot_svd_yale_exc);
xlabel('k');
ylabel('Recognition rate in %');
title('Recognition rates after removing top 3 eigenvalues (Yale dataset)');
toc;