function visualize(input_image)
    upperLeft = input_image;
    upperRight = input_image(:, :, 1);
    lowerLeft = input_image(:, :, 2);
    lowerRight = input_image(:, :, 3);
    figure()
    subplot(2,2,1)
    imshow(upperLeft)
    subplot(2,2,2)
    imshow(upperRight)
    subplot(2,2,3)
    imshow(lowerLeft)
    subplot(2,2,4)
    imshow(lowerRight);
end

