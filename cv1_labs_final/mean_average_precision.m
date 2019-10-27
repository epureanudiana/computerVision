% compute mean average precision given the number of images(variable n) 
% class c, and the number of element is the class m
function [index, class, m] = map(n, c, m)
    result = 0;
    for j = 1 : n
        result = result + histo(c, i)/j
    end
    
    result = result / m
end