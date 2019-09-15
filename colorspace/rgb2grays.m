function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[r, g, b] = getColorChannels(input_image);
% ligtness method
outputLightness = (max(input_image, 3)+ min(input_image, 3))./2;
s = size(outputLightness)
% average method
outputAverage = (r+b+g)./3; 
% luminosity method
outputLuminosity =  0.21*r + 0.72*g + 0.07*b;
% built-in MATLAB function 
outputMatlab = rgb2gray(input_image);
output_image = cat(3,outputLightness,outputAverage, outputLuminosity);
end

