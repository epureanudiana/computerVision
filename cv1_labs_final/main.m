run('./vlfeat-0.9.21/toolbox/vl_setup')
train_data = load("train.mat");
test_data = load("test.mat");

% variable representing whether or not to do first part 
todo = true;

%remove unnecessary classes
if todo
    [train_images, train_labels, test_images, test_labels] = clean_data(train_data, test_data);
end
%sort according to label
[sorted_train_images, sorted_train_labels] = sort_data(train_images, train_labels);

% split data for building and computing visual dictionary
[build_training_images, build_training_labels, ...
    compute_training_images, compute_training_labels] = split_data(sorted_train_images, sorted_train_labels, 250);

% build vocabulary
[all_descriptors, centers, assignments] = build_vocabulary(build_training_images);

% encode features
[histogram, ids] = encode_features(centers, compute_training_images, 'keypoints', 'grayscale');

% create histogram
histogram(histogram)

% do SVM and create histohgrams
svm_classifier = fitcsvm(histogram, build_training_labels,'Standardize',true,'KernelFunction','RBF',...
    'KernelScale','auto');
[classifier, scores] = fitPosterior(svm_classifier);predict(svm_classifier,compute_training_images)
% compute mean average precision for each class

%number of images of a class
m = 50;
% number of images
n = 100;

map(0, n, 1, m, classifier);
map(0, n, 2, m, classifier);
map(0, n, 3, m, classifier);
map(0, n, 4, m, classifier);
map(0, n, 5, m, classifier);
