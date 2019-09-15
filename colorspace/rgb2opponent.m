function [output_image] = rgb2opponent(input_image)
% converts an RGB image into opponent color space
   % retrieve color channels
   [red, green, blue] = getColorChannels(input_image);
   % convert each color channel
   o1 = (red-green)./sqrt(2);
   o2 = (red+green-2*blue)./sqrt(6);
   o3 = (red+green+blue)./sqrt(3);
   % recombine color channels
   output_image = cat(3, o1, o2, o3); 
end

