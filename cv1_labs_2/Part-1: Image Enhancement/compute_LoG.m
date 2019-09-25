function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        % Gaussian kernel of size 5 and sd = 0.5 +  laplacian
        h = fspecial('gaussian', 5, 0.5);
        smoothImage = imfilter(image, h);
        h2 = fspecial('laplacian', 0.2);
        imOut = imfilter(smoothImage, h2);
        imOut = normalize(imOut);

    case 2
        %method 2
        % LoG kernel of size 5 and sd = 0.5
        h = fspecial('log', 5, 0.5);
        imOut = imfilter(image, h);
        imOut = normalize(imOut);
        

    case 3
        %method 3
        % DoG computed at different scales sigma_1 and sigma_2
        h_1 = fspecial('gaussian', 5, 0.5);
        h_2 = fspecial('gaussian', 5, 1.5);
        img_2 = imfilter(image, h_2);
        img_1 = imfilter(image, h_1);
        imOut = img_1-img_2;
        imOut = normalize(imOut);
       
end
end

