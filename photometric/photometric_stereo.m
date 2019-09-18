close all
clear all
clc
 
disp('Part 1: Photometric Stereo')

% obtain many images in a fixed view under different illumination
disp('Loading images...')
image_dir = './SphereGray5/';   % TODO: get the path of the script
%image_ext = '*.png';

[image_stack, scriptV] = load_syn_images(image_dir);
[h, w, n] = size(image_stack);
fprintf('Finish loading %d images.\n\n', n);

%use this if clause for ease in changing the input image stack from
%grayscale to color and back
if contains(image_dir,'Color')
    image_stackR = image_stack;
    [image_stackG, ~] = load_syn_images(image_dir, 2);
    [image_stackB, scriptV] = load_syn_images(image_dir, 3);

    red = image_stackR;
    green = image_stackG;
    blue = image_stackB;

    %create a black and white image stack to be used in the calculation of the
    %normal for the RGB images
    rgbImages = zeros(h,w,3,n);
    bwImages = zeros(h,w,3);
    for page = 1:n
        rgbImages(:,:,:,page) = cat(3, red(:,:,page), green(:,:,page), blue(:,:,page));
        bwImages(:,:,page)=rgb2gray(rgbImages(:,:,:,page));
    end
end

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
if contains(image_dir, 'Color')
    %compute the normal based on the grayscale image stack
    [~,normals] = estimate_alb_nrm(bwImages, scriptV);
    [albedo1, ~] = estimate_alb_nrm(image_stackR, scriptV);
    [albedo2, ~] = estimate_alb_nrm(image_stackG, scriptV);
    [albedo3, ~] = estimate_alb_nrm(image_stackB, scriptV);
    %construct the albedo based on all 3 channels
    albedo = cat(3, albedo1, albedo2, albedo3);
else 
    [albedo, normals] = estimate_alb_nrm(image_stack, scriptV);
end

%{ 
% QUESTION 1.1 

%Figure showing the albedo for SphereGray5 with shadow trick
subplot(2, 2, 1) 
imshow(albedo)
title('Estimated albedo for SphereGray5', 'FontSize', 8)


% Figure showing the albedo for SphereGray5 without shadow trick
[albedo_2, ~] = estimate_alb_nrm(image_stack, scriptV, false);
subplot(2, 2, 2) 
imshow(albedo)
title('Estimated albedo for SphereGray5 without shadow trick', 'FontSize', 8)

% Run the algorithm on SphereGray25
image_dir = './SphereGray25/';   % TODO: get the path of the script
[image_stack_25, scriptV_25] = load_syn_images(image_dir);

% compute the surface gradient from the stack of imgs and light source mat
disp('Computing surface albedo and normal map...')
[albedo_25, ~] = estimate_alb_nrm(image_stack_25, scriptV_25);
[albedo_25_2, ~] = estimate_alb_nrm(image_stack_25, scriptV_25, false);

% Figure showing the albedo for SphereGray25 with shadow trick
subplot(2, 2, 3)
imshow(albedo_25)
title('Estimated albedo for SphereGray25', 'FontSize', 8)


% Figure showing the albedo for SphereGray25 without shadow trick
subplot(2, 2, 4)
imshow(albedo_25_2)
title('Estimated albedo for SphereGray25 without shadow trick', 'FontSize', 8)
%}

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);
threshold = 0.1;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface(p, q ); % height_map using column-order

%% Display
show_results(albedo, normals, SE);
show_model(albedo, height_map); %column-order major model

%{
% QUESTION 1.3
height_map_row = construct_surface(p, q, 'row');
height_map_average = construct_surface(p, q, 'average');

show_model(albedo, height_map_row); % row-order major model
show_model(albedo, height_map_average); % average model
%}
%% Face
[image_stack, scriptV] = load_face_images('./yaleB02/');
[h, w, n] = size(image_stack);

fprintf('Finish loading %d images.\n\n', n);
disp('Computing surface albedo and normal map...')
[albedo, normals] = estimate_alb_nrm(image_stack, scriptV, false);

%% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
disp('Integrability checking')
[p, q, SE] = check_integrability(normals);

threshold = 0.1;
SE(SE <= threshold) = NaN; % for good visualization
fprintf('Number of outliers: %d\n\n', sum(sum(SE > threshold)));

%% compute the surface height
height_map = construct_surface( p, q );

show_results(albedo, normals, SE);
show_model(albedo, height_map);

%{
% QUESTION 1.4.6
height_map_row = construct_surface( p, q, 'row' );
height_map_avg = construct_surface( p, q, 'average');
show_model(albedo, height_map_row);
show_model(albedo, height_map_avg);
%}