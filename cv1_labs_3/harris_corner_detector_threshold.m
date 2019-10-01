% read images
img_pingpong = imread("pingpong/0000.jpeg");
img_toy = imread("person_toy/00000001.jpg");

figure("Name", "Adjusting threshold image 1")
for i = 10:10:100
    [H, r, c, Ix, Iy] = harris_corner_detector(img_pingpong, i);
    subplot(2,5,i/10);
    imshow(img_pingpong);
    axis on
    hold on;
    % Plot corner points on the original image too
    plot(r,c, 'b+', 'MarkerSize', 1, 'LineWidth', 2);
    title("threshold = maxValue/" + num2str(i));
    set(gca,'FontSize',10)
    
end

figure("Name", "Adjusting threshold image 2")
for i = 10:10:100
    [H, r, c, Ix, Iy] = harris_corner_detector(img_toy,i);
    subplot(2,5,i/10);
    imshow(img_toy);
    axis on
    hold on;
    % Plot corner points on the original image too
    plot(r,c, 'b+', 'MarkerSize', 1, 'LineWidth', 2);
    title("threshold = maxValue/" + num2str(i));
    set(gca,'FontSize',10)
    
end