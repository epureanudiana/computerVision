train_data = load("train.mat");
test_data = load("test.mat");
[train_images, train_labels, test_images, test_labels] = clean_data(train_data, test_data);
  