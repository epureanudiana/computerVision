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
title('albedo') 
imshow(albedo_d)
subplot(2,2,2)
title('shading') 
imshow(shading_d)
subplot(2,2,3)
title('original')  
imshow(ball)
subplot(2,2,4)
title('reconstructed')  
imshow(reconstructed);
