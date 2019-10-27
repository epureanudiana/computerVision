% compute mean average precision given the number of images(variable n) 
% class c, and the number of element is the class m
function [result]  = map(index, n, c, m, results, classifier)
    result = 0;
    if classifier[n] == c
        result = results + ((map(index+1, n, c, m, results, classifier) + 1)/index)/m; 
    elseif index == n
        result = 0 
    else
        result = (map(index+1, n, c, m, results, classifier); 
    end
end