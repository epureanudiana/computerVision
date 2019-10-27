function [histogram_map, ids] = encode_features(visual_words, compute_training_images, descriptor_type, SIFT_type)
    
    histogram_map = zeros(1250, 400);
    for i = 1: size(compute_training_images,1)
        [~, descriptors] = extract_features(compute_training_images(i,:), descriptor_type, SIFT_type);
        descriptors = double(descriptors);
        [~, ids] = min(vl_alldist2(descriptors, visual_words), [],2);
        histogram = histcounts(ids, 1:size(visual_words, 2) + 1);
        histogram = histogram ./ sum(histogram, 'all');
        histogram_map(i, :) = histogram;
    end    
end