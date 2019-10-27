function  [all_descriptors, centers, assignments] = build_vocabulary(build_training_images)
    % for each image in the build set: 
    %   1. extract features
    %   2. compute k-means on descriptors
    for i = 1: size(build_training_images, 1)
       [~, descriptors] = extract_features(build_training_images(i, :), 'keypoints', 'grayscale');
       descriptors = double(descriptors);    
       if i == 1
            all_descriptors = transpose(descriptors);
        else
            all_descriptors = [all_descriptors; transpose(descriptors)];
        end    
    end

    [centers, assignments] = vl_kmeans(transpose(all_descriptors), 400);

end