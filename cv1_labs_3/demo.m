im1 = imread('sphere1.ppm');
im2 = imread('sphere2.ppm');

figure(2);
subplot(121);
imshow(im1);
hold on;
[v_x, v_y] = lucas_kanade(im1,im2);
title("Sphere");

im1 = imread('synth1.pgm');
im2 = imread('synth2.pgm');
subplot(122);
imshow(im1);
hold on;
[v_x, v_y] = lucas_kanade(im1,im2);
title("Synth");