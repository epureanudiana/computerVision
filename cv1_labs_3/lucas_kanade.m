function[v_x, v_y] = lucas_kanade(image_1, image_2)

[im_rows, im_cols, channels] = size(image_1);

% turn colored images to greyscale
if (channels == 3)
    image_1 = rgb2gray(image_1);
    image_2 = rgb2gray(image_2);
end

image_1 = im2double(image_1);
image_2 = im2double(image_2);

%if the image sizes are not divisible by 15, crop to proper size
rows_block = floor(im_rows / 15);
cols_block = floor(im_cols / 15);

image_1 = image_1(1:rows_block*15, 1:cols_block*15, :);
image_2 = image_2(1:rows_block*15, 1:cols_block*15, :);
%% Compute the partial derivatives with respect to x, y and t
[I_x, I_y] = imgradientxy(image_1);
I_t = image_2 - image_1;
% initialize variables for center pixels and optical flow
x = zeros(rows_block * cols_block, 1);
y = zeros(rows_block * cols_block, 1);
v_x = zeros(rows_block * cols_block, 1);
v_y = zeros(rows_block * cols_block, 1);
c = 1;

% iterate per region
for i = 1:rows_block
    for j = 1:cols_block
        % pick the center pixel and the pixels around it
        x(c) = j * 15 - 7;
        y(c) = i * 15 - 7;
        p_x = I_x((i - 1) * 15 + 1 : i * 15, (j - 1) * 15 + 1: j * 15);
        p_y = I_y((i - 1) * 15 + 1 : i * 15, (j - 1) * 15 + 1: j * 15);
        p_t = I_t((i - 1) * 15 + 1 : i * 15, (j - 1) * 15 + 1: j * 15);
        
        % compute A based on the pixels around the center
        A = [p_x(:) p_y(:)];
        b = -p_t(:);
        
        % use the pseudo-inverse to cover the cases when the inverse does
        % not exist
        v = pinv(A' * A) * A' * b;
        v_x(c) = v(1);
        v_y(c) = v(2);
        c = c + 1;
    end
end

quiver(x, y, v_x, v_y);
end