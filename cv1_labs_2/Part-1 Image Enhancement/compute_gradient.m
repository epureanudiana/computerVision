function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
 
 sobel = [1,0,-1;2,0,-2;1,0,-1];
 Gx = conv2(sobel, image);
 Gy = conv2(sobel', image); 
 im_magnitude = sqrt(Gx.^2 + Gy.^2);
 im_direction = atan2d(-Gy, Gx);
 
end

