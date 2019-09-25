function [ PSNR ] = myPSNR( orig_image, approx_image )
orig_image = double(orig_image);
approx_image = double(approx_image);

[m, n] = size(orig_image);

MSE = sum(sum((orig_image - approx_image).^2)) / (m*n);
PSNR = 20 * log10(max(max(orig_image)) / sqrt(MSE));

end

