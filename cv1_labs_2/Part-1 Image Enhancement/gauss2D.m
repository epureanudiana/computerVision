function G = gauss2D( sigma , kernel_size )
    gauss1x = gauss1D(sigma, kernel_size);
    gauss1y = transpose(gauss1D(sigma, kernel_size));
    G = gauss1y*gauss1x;
    
    %%% alternative solution using Eq 5.
    %x = -floor(kernel_size/2): 1: floor(kernel_size/2);
    %y = transpose(x);
    %denominator = (sigma^2)*2*pi;
    %fraction = -(x.^2 + y.^2)./(2*(sigma^2));
    %G = exp(fraction)/denominator;
    G = G./sum(G,'all');
end
