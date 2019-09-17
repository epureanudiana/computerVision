
clear
clc
close all

% read image and extract dimensions
I = imread('awb.jpg');
[rows, columns, ~] = size(I);

% extract color channels
r = I(:, :, 1);
g = I(:, :, 2);
b = I(:, :, 3);

% adjust pixels per channel
r_c = 128/mean(r, 'all')*r;
g_c = 128/mean(g, 'all')*g;
b_c = 128/mean(b, 'all')*b;
% recreate the image
corrected_image = cat(3, r_c, g_c, b_c);

figure()
subplot(1,2,1)
imshow(I)
title("Original")
subplot(1,2,2)
imshow(corrected_image)
title("Color corrected image")