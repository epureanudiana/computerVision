%% Question 6 ------------------------------------------------------------
orig_image = imread('images/image1.jpg');
approx_image = imread('images/image1_saltpepper.jpg');

PSNR = myPSNR( orig_image, approx_image );
disp("Question 6.2. PSNR = " + PSNR);

approx_image2 = imread('images/image1_gaussian.jpg');
PSNR2 = myPSNR(orig_image, approx_image2);
disp("   PSNR2 = " + PSNR2);

%% Question 7 ------------------------------------------------------------
denoised_PSNR = zeros(1, 12);

% image1_saltpepper.jpg
figure(1)
subplot(2, 3, 1)
imOut = denoise(approx_image, 'box', 3);
denoised_PSNR(1) = myPSNR(orig_image, imOut);
imshow(imOut);
title('3x3');

subplot(2, 3, 2)
imOut = denoise(approx_image, 'box', 5);
imshow(imOut);
denoised_PSNR(2) = myPSNR(orig_image, imOut);
title({'Box Filtering of image1\_saltpepper.jpg', '', '5x5'});

subplot(2, 3, 3)
imOut = denoise(approx_image, 'box', 7);
denoised_PSNR(3) = myPSNR(orig_image, imOut);
imshow(imOut);
title('7x7');

subplot(2, 3, 4)
imOut = denoise(approx_image, 'median', 3);
imshow(imOut);
denoised_PSNR(4) = myPSNR(orig_image, imOut);
title('3x3');

subplot(2, 3, 5)
imOut = denoise(approx_image, 'median', 5);
imshow(imOut);
denoised_PSNR(5) = myPSNR(orig_image, imOut);
title({'Median Filtering of image1\_saltpepper.jpg', '', '5x5'});

subplot(2, 3, 6)
imOut = denoise(approx_image, 'median', 7);
imshow(imOut);
denoised_PSNR(6) = myPSNR(orig_image, imOut);
title('7x7');

% image1_gaussian.jpg
figure(2)
subplot(2, 3, 1)
imOut = denoise(approx_image2, 'box', 3);
denoised_PSNR(7) = myPSNR(orig_image, imOut);
imshow(imOut);
title('3x3');

subplot(2, 3, 2)
imOut = denoise(approx_image2, 'box', 5);
imshow(imOut);
denoised_PSNR(8) = myPSNR(orig_image, imOut);
title({'Box Filtering of image1\_gaussian.jpg', '', '5x5'});

subplot(2, 3, 3)
imOut = denoise(approx_image2, 'box', 7);
denoised_PSNR(9) = myPSNR(orig_image, imOut);
imshow(imOut);
title('7x7');

subplot(2, 3, 4)
imOut = denoise(approx_image2, 'median', 3);
imshow(imOut);
denoised_PSNR(10) = myPSNR(orig_image, imOut);
title('3x3');

subplot(2, 3, 5)
imOut = denoise(approx_image2, 'median', 5);
imshow(imOut);
denoised_PSNR(11) = myPSNR(orig_image, imOut);
title({'Median Filtering of image1\_gaussian.jpg', '', '5x5'});

subplot(2, 3, 6)
imOut = denoise(approx_image2, 'median', 7);
imshow(imOut);
denoised_PSNR(12) = myPSNR(orig_image, imOut);
title('7x7');

disp(denoised_PSNR)

% gaussian filter
window_size = [3, 5, 7];
sigma = 0.1:0.1:1;
ls = length(sigma);
ws = length(window_size);
find_PSNR = zeros(ls, ws);

%{
figure(3)
% check the resulting gaussians
ctr = 1;
for i = 1:ls
    for j = 1:ws
        subplot(ls, ws, ctr)
        imOut = denoise(approx_image2, 'gaussian', sigma(i), window_size(j));
        imshow(imOut);
        find_PSNR(i, j) = myPSNR(orig_image, imOut);
        ctr = ctr + 1;
    end
end
%}

% the best result seems to be around 0.8
figure(3)
imshow(denoise(approx_image2, 'gaussian', 0.8, 3));
title("Gaussian Filtering for image1\_gaussian.jpg");

figure(4)
subplot(121)
imshow(gauss2D( 0.1 , 3 ))
subplot(122)
imshow(gauss2D( 0.8 , 3 ))
    
    
    