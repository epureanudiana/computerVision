function [train_images,train_labels] = sort_data(images, labels)
    C = cat(2, images, labels);
    sortedC = sortrows(C, size(C,2));
    
    train_images = sortedC(:, 1:(size(C,2)-1));
    train_labels = sortedC(:, size(C,2));
    
end