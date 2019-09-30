im = imread('images\image2.jpg');
im = im2double(im); %so we can apply sqrt to the magnitude
[Gx, Gy, mag, dir] = compute_gradient(im);
subplot(2,2,1); imshow(Gx);
title('Gradient in the x-direction');
subplot(2,2,2); imshow(Gy);
title('Gradient in the y-direction');
subplot(2,2,3); imshow(mag);
title('Magnitude of gradient');
subplot(2,2,4); imshow(dir);
title('Direction of gradient');