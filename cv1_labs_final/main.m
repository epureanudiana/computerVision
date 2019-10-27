run('./vlfeat-0.9.21/toolbox/vl_setup')
train_data = load("train.mat");
test_data = load("test.mat");

%remove unnecessary classes
[train_images, train_labels, test_images, test_labels] = clean_data(train_data, test_data);

%sort according to label
[sorted_train_images, sorted_train_labels] = sort_data(train_images, train_labels);

% split data for building and computing visual dictionary
[build_training_images, build_training_labels, ...
    compute_training_images, compute_training_labels] = split_data(sorted_train_images, sorted_train_labels, 1);


% build vocabulary
% for each image in the build set: 
%   1. extract features
%   2. compute k-means on descriptors
for i = 1: size(build_training_images, 1)
   [frames, descriptors] = extract_features(build_training_images(i, :), 'keypoints', 'grayscale');
end