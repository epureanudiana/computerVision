clc;
% test for 1D and 2D Gaussian
img = imread('images/image1.jpg');
imgd = im2double(img);
% 1D Gaussian filter on x
filter1D = gauss1D(2,5);
% 1D Gaussian filter on y 
filter1D2 = transpose(filter1D);
% 2D Gaussian filter
filter2D = gauss2D(2,5);
% convolve original image with two 1D Gaussian
conv1D = imfilter(imgd, filter1D);
conv1D = imfilter(conv1D, filter1D2);
% convolve original image with 2D Gaussian
conv2D = imfilter(imgd, filter2D);

%display results and also check whether they are equal
figure('Name', "Two 1D Gaussian filters vs one 2D Gaussian filter");
subplot(1,2,1);
imshow(conv1D);
subplot(1,2,2);
imshow(conv2D);
all(eq(conv1D, conv2D))
