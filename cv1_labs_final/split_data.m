% we take a subset of all training images containing equal nr of images 
% from each category. With this we will build the visual vocabulary
% the rest of the training images will be used to calculate the visual
% dictionary
function [build_training_images, build_training_labels, ...
    compute_training_images, compute_training_labels] = split_data(images, labels, subset_size)

    build_training_images = zeros(5*subset_size, 27648 );
    build_training_labels = zeros(5*subset_size, 1);
    compute_training_images = zeros(5*(500-subset_size), 27648);
    compute_training_labels = zeros(5*(500-subset_size), 1);
    
    index = 1;
    for j = 1 : 500 : 2500
        for i = 1 : subset_size
            build_training_images(index, :) = images(j+i-1, :);
            build_training_labels(index, 1) = labels(j+i-1, 1);
            index = index + 1;
        end
    end
    
    index = 1;
    for j = 1 : 500 : 2500
        for i = subset_size + 1: 500
            compute_training_images(index, :) = images(j+i-1, :);
            compute_training_labels(index, 1) = labels(j+i-1, 1);
            index = index + 1;
        end    
    end  
    
    build_training_images = uint8(build_training_images);
    compute_training_images = uint8(compute_training_images);
end