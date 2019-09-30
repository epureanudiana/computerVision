% read image
%img = imread("person_toy/00000001.jpg");
img = imread("person_toy/00000001.jpg");

[r, c] = harris_corner_detector(img);
figure("Name", "Harris corner detection results");
imshow(img);
axis on
hold on;
% Plot cross at row 100, column 50
plot(r,c, 'r+', 'MarkerSize', 20, 'LineWidth', 2);