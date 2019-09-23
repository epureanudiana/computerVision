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
