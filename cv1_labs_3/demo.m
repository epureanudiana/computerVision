im1 = imread('sphere1.ppm');
im2 = imread('sphere2.ppm');

imshow(im1);
hold on;
[v_x, v_y] = lucas_kanade(im1,im2);