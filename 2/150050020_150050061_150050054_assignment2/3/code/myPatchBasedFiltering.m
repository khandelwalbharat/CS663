  function myPatchBasedFiltering( img )
  % MYPATCHBASEDFILTERING Summary of this function goes here
  %   Detailed explanation goes here    

%   Report

%   The optimal parameter found is 0.83 with RMSD 3.01
%   This was found by varying sigma in a loop and finding the point with the least RMSD.

%   RMSD values for 0.9*sigma or 0.76 = 3.063 and for 1.1*sigma or 0.91 = 3.03


%   Explanation of the procedure-

%   We found that the process was taking more time and so we took the approach as mentioned in the document.
%   We first took the guassian blur of the image given and the downsampled the image. We then added a guassian noise 
%   to the image and then applied the patch based filtering technique.
%   In this technique - for every pixel in the image lets say a, we took a window around the image of size 25 * 25 (if possible) 
%   and then for every possible pixel in the window lets say b, if possible we considered the patch centered at that pixel 
%   (pixel b), we weight pixel b by the similarity of the patches around a and b.
%   To make the patches isotropic, we multiplied a guassian filter to the difference vector (difference of the two patches)
%   This is so that firstly symmetry is maintained and more importantly because the farther away pixels in the patch should 
%   have a smaller weight in deciding the similarity as in the end we would just consider the intensity of the center of the 
%   patch.

%   The parameters used are -
%   for adding noise, we added a guassian random variable with std deviation about sqrt(30) or around 5.5 percent of the range
%   for the guassian filter for isotropic, we added a guassian with std deviation of 2 ( as patch size is 9 so on either direction
%   its 4 . By 3*sigma rule we want our sigma to be a little more.)

%   LimitPatch1, LimitPatch2, LimitWindow is for covering the corner cases if the central pixel or the other patch's pixels are near corners.

      hwindow = 10;
      sig = 0.66;
      G = fspecial('gaussian', [2*hwindow+1 2*hwindow+1], sig);
      previmg= imfilter(img,G);
      
      [m n] = size(previmg);
      index_x = 1:2:m;
      index_y = 1:2:n;
      previmg = previmg(index_x, index_y);
            
      origimg=previmg;
      
      [m n] =size(previmg);
      previmg=previmg+sqrt(0.3*(max(max(previmg))-min(min(previmg))))*randn(m,n);
      
      guassian_filter=fspecial('gaussian', [9 9], 2);

      set_sigma=0.83
      newimg=previmg;

      [m n p] = size(newimg);

      for i=1:m
          for j=1:n

% LimitPatch1 is the distance that the patch at the central pixel (pixel i,j) can be in all the directions. Max value is 4 in any direction

                leftLimitPatch1=min(4,j-1);
                rightLimitPatch1=min(4,n-j);
                topLimitPatch1=min(4,i-1);
                bottomLimitPatch1=min(4,m-i);

% LimitWindow is the limits of the window that can be created keeping in mind the corner cases. Max window is 25*25.

                leftLimitWindow=max(1,j-12);
                rightLimitWindow=min(n,j+12);
                topLimitWindow=max(1,i-12);
                bottomLimitWindow=min(m,i+12);

                weight=zeros(bottomLimitWindow-topLimitWindow, rightLimitWindow-leftLimitWindow+1);

                for k=topLimitWindow:bottomLimitWindow

                  for l=leftLimitWindow:rightLimitWindow

% LimitPatch2 is the distance that the patch at the pixel in the window (pixel k,l) can be in all the directions. Max value is 4 in any direction

                    leftLimitPatch2=min(min(4,l-leftLimitWindow),leftLimitPatch1);
                    rightLimitPatch2=min(min(4,rightLimitWindow-l),rightLimitPatch1);
                    topLimitPatch2=min(min(4,k-topLimitWindow),topLimitPatch1);
                    bottomLimitPatch2=min(min(4,bottomLimitWindow-k),bottomLimitPatch1);


                    patch1=previmg(i-topLimitPatch2:i+bottomLimitPatch2,j-leftLimitPatch2:j+rightLimitPatch2);
                    patch2=previmg(k-topLimitPatch2:k+bottomLimitPatch2,l-leftLimitPatch2:l+rightLimitPatch2);
                    difference=patch1-patch2;
                    difference=difference.*guassian_filter(5-topLimitPatch2:5+bottomLimitPatch2,5-leftLimitPatch2:5+rightLimitPatch2);

      
                    weight(k-topLimitWindow+1,l-leftLimitWindow+1)=exp(-sum(sum(difference.^2))/(set_sigma*set_sigma));

                  end

                end

                newimg(i,j)=sum(sum(weight.*previmg(topLimitWindow:bottomLimitWindow,leftLimitWindow:rightLimitWindow)))/sum(sum(weight)); 
          end
      end
      set_sigma
      
      rmsd= sqrt(sum(sum((newimg-origimg).^2))/(m*n))
      
    figure;
    subplot(1,3,1);
    imagesc((origimg/100));
    daspect([1 1 1]);
    axis tight;
    colormap('Gray');
    title('Original');

    subplot(1,3,2);
    imagesc((previmg/100));
    daspect([1 1 1]);
    axis tight;
    colormap('Gray');
    title('Corrupted');
    
    subplot(1,3,3);
    imagesc((newimg/100));
    daspect([1 1 1]);
    axis tight;
    colormap('Gray');
    title('Filtered');
    

    figure;
    imagesc(guassian_filter);
    daspect([1 1 1]);
    axis tight;
    colormap('Gray');
    title('Guassian Filter');
    colorbar;

  end

