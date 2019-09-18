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

color = albedo_d(rows/2, columns/2, :)

reconstructed = zeros(rows, columns, depth);
for i = 1:rows
    for j = 1:columns 
            if ball(i,j,:) == [0, 0, 0]
                reconstructed(i , j, : ) = ball(i, j, :);
            else
                reconstructed(i, j, :) = [0, 255 * shading_d(i, j), 0];
        end    
    end
end 

figure()
subplot(1,2,1)  
imshow(ball)
title('Original image')
subplot(1,2,2)
imshow(reconstructed);
title('Reconstructed image')  
