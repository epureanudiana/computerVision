function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb
   % retrieve color channels
   [red, green, blue] = getColorChannels(input_image);
   % convert each color channel
   r = red./(red+green+blue);
   g = green./(red+green+blue);
   b = blue./(red+green+blue);
   % recombine color channels
   output_image = cat(3, r, g, b); 
end

