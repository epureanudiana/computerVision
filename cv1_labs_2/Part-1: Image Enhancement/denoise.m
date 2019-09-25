function [ imOut ] = denoise( image, kernel_type, varargin)

switch kernel_type
    case 'box'
        kernel_size = varargin{1};
        imOut = imboxfilt(image, kernel_size);
    case 'median'
        kernel_size = varargin{1};
        imOut = medfilt2(image, [kernel_size kernel_size]);
    case 'gaussian'
        sigma = varargin{1};
        kernel_size = varargin{2};
        imOut = gauss2D(sigma, kernel_size);
        imOut = imfilter(image, imOut);
        % image is padded, crop it
        imOut = imOut(1:size(image, 1), 1:size(image,2));
end
end
