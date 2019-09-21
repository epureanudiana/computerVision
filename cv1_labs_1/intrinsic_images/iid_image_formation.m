clear
clc
close all

ball = imread('ball.png');
s = size(ball)
albedo = imread('ball_albedo.png');
s2 = size(albedo)
shading = imread('ball_shading.png');
s3 = size(shading)
albedo_d = im2double(albedo);
shading_d = im2double(shading);

[rows, columns, depth] = size(ball);
reconstructed = zeros(rows, columns, depth);
for i = 1:rows
    for j = 1:columns 
        for k = 1:depth
            reconstructed(i, j, k) = shading_d(i,j)*albedo_d(i,j,k);
        end    
    end
end 

figure()
subplot(2,2,1)
imshow(albedo_d)
title('Albedo') 
subplot(2,2,2)
imshow(shading_d)
title('Shading') 
subplot(2,2,3)  
imshow(ball)
title('Original image')
subplot(2,2,4)
imshow(reconstructed);
title('Reconstructed image')  
