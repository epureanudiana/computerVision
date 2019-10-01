% read image
img_pingpong = imread("pingpong/0000.jpeg");
%img_pingpong = imrotate(img_pingpong, 45);
[H, r, c, Ix, Iy] = harris_corner_detector(img_pingpong,70);

img_toy = imread("person_toy/00000001.jpg");
%img_toy = imrotate(img_toy, 45);
[H2, r2, c2, Ix2, Iy2] = harris_corner_detector(img_toy,70);


figure("Name", "Harris corner detection results");
subplot(3,2,1);
imshow(img_pingpong);
axis on
hold on;
% Plot corner points on the original image too
plot(r,c, 'b+', 'MarkerSize', 7, 'LineWidth', 2);
title("Original image + corner points")
subplot(3,2,2);
imshow(img_toy);
axis on
hold on;
% Plot corner points on the original image too
plot(r2,c2, 'b+', 'MarkerSize', 7, 'LineWidth', 2);
title("Original image + corner points")
subplot(3,2,3);
imshow(Ix);
title("Ix derivative");
subplot(3,2,4);
imshow(Ix2);
title("Ix derivative");
subplot(3,2,5);
imshow(Iy);
title("Iy derivative")
subplot(3,2,6);
imshow(Iy2);
title("Iy derivative");
