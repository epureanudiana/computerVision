
img = imread('images/image2.jpg');
image = im2double(img);
h = fspecial('log', 5, 0.5);
imOut1 = imfilter(image, h);

h_1 = fspecial('gaussian', 5, 0.5);
MSE = zeros(1,70);
ratio = zeros(1,70);
k = 1;
for i = 1:0.1:8
 h_2 = fspecial('gaussian', 5, 0.5*i);
 img_2 = imfilter(image, h_2);
 img_1 = imfilter(image, h_1);
 imOut2 = img_2-img_1;
 MSE(k) = immse(imOut1, imOut2);
 ratio(k) = 0.5*i/0.5;
 k = k + 1;   
end 
[val,ind] = min(MSE(~ismember(MSE,0)))
plot(MSE)
title('Tuning the Difference of Gaussians sigmas')
xlabel('ratio') 
ylabel('Mean Squared Error') 

 