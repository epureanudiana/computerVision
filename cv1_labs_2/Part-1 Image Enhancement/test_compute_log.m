clc
img = imread('images/image2.jpg');
imgd = im2double(img);
figure('Name', 'Second-order derivative filters');
subplot(2,2,1);
imshow(imgd);
title('Original image');
set(gca,'FontSize',15)
subplot(2,2,2);
imshow(compute_LoG(imgd, 1));
title('Smoothing + Laplacian filter')
set(gca,'FontSize',15)
subplot(2,2,3);
imshow(compute_LoG(imgd, 2));
title('Laplacian of Gaussian filter')
set(gca,'FontSize',15)
subplot(2,2,4);
imshow(compute_LoG(imgd, 3));
title('Difference of Gaussian filter')
set(gca,'FontSize',15)