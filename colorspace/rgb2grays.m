function [output_image] = rgb2grays(input_image)
% converts an RGB into grayscale by using 4 different methods
[r,g,b] = getColorChannels(input_image);
% lightness method
[rows, columns, ~] = size(input_image);
outputLightness = zeros(rows, columns);
for i = 1:rows
    for j = 1:columns  
        outputLightness(i, j) = (max(input_image(i, j, :))+ min(input_image(i, j, :)))/2;
    end
end
% average method
outputAverage = (r+b+g)./3; 
% luminosity method
outputLuminosity =  0.21*r + 0.72*g + 0.07*b;
% built-in MATLAB function 
outputMatlab = rgb2gray(input_image);
lightnessAverage = cat(2,outputLightness, outputAverage );
luminosityMatlab = cat(2,outputLuminosity,outputMatlab);
extra = zeros(rows, 2*columns);
output_image = cat(3,lightnessAverage, luminosityMatlab, extra);
end

