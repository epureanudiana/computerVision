function result = harris_corner_detector(img)
% convert to gray scale
img_black = rgb2gray(img);


% convert to double
img_d = im2double(img_black);


% create gaussian filters on x and y
filter_x = gauss1D_d(2,5);
filter_y = gauss1D_d(2,5)';


% smoothed derivative of the image on x
Ix = imfilter(img_d, filter_x);


% convolve result with gaussian
A = imgaussfilt((Ix).^2);


% smoothed derivative of the image on y
Iy = imfilter(img_d, filter_y);


% convolve result with gaussian
C = imgaussfilt((Iy).^2);


% calculate B
B = Ix.*Iy;


% calculate H
H = ((A.*C)-(B.^2)) - (0.04*((A+C).^2));


% pad with zeros
H = padarray(H, [1 1]);


% define result matrix
rows = size(H, 1);
columns = size(H, 2);
result = zeros(rows, columns);
Hmax = max(max(H));


% set threshold
threshold = Hmax;

for i = 2: rows -1
    for j = 2: columns -1
        %window = H(i-2:i+2, j-2:j+2);
        %idx =  (H(i,j)> threshold) & (maxW == H(i,j));
        if H(i,j) > threshold/10 && H(i,j) > H(i-1,j-1) ...
            && H(i,j) > H(i-1,j) && H(i,j) > H(i-1,j+1)  ...
            && H(i,j) > H(i,j-1) && H(i,j) > H(i,j+1)    ...
            && H(i,j) > H(i+1,j-1) && H(i,j) > H(i+1,j)  ...
            && H(i,j) > H(i+1,j+1)
                result(i,j) = H(i,j);
        end
    end
end


% figure(1);
% imshow(img_d);
% figure(2);
% imshow(H);
% figure(3);
% imshow(result);
end
% create derivative of gaussian function
function G_d = gauss1D_d(sigma, kernel_size)
    x = -floor(kernel_size/2): 1: floor(kernel_size/2);
    G_d = (-x.*gauss1D(sigma, kernel_size))./(sigma^2);
    % normalize kernel
    G_d = G_d./(sum(G_d));
end
% create gaussian function and derivative
function G = gauss1D( sigma , kernel_size )
    %G = zeros(1, kernel_size);
    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end
    %% solution
    % create array of integers depending on the kernel size
    x = -floor(kernel_size/2): 1: floor(kernel_size/2);
    % define the filter according to the definition
    numerator = exp(-(x.^2)./(2*(sigma^2)));
    denominator = sigma*(sqrt(2*pi));
    G = numerator/denominator;
    % normalize the filter
    G = G./(sum(G));
    
    
end