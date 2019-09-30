% read image
%img = imread("person_toy/00000001.jpg");
img = imread("person_toy/00000001.jpg");
figure('Name', "Original image");
imshow(img);

result = harris_corner_detector(img);
figure("Name", "Harris corner detection results");
imshow(result);