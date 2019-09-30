
lambda = 30;
sigmas = [0.5,1,5,20,40];
sigma = 5;

theta = pi/4;
thetas = 0:pi/6:3*theta;

psi = 0;
gammas = [0.1,0.4,0.7,1,2];
gamma = 0.1;

for i = 1:length(sigmas)
    filterPairs = createGabor( sigmas(i), theta, lambda, psi, gamma );
    subplot(3,5,i); imshow(filterPairs(:,:,1));
    if(i == 3)
        title({"Varying \sigma and constant \theta = \pi/4, \lambda = 30, \psi = 0, \gamma = 0.1","\sigma = " + sigmas(i)});
    else
        title("\sigma = "+ sigmas(i))
    end  
end

for i = 1:length(thetas)
    filterPairs = createGabor( sigma, thetas(i), lambda, psi, gamma );
    subplot(3,5,i+5); imshow(filterPairs(:,:,1));
    if(i == 3)
        title({"Varying \theta and constant \sigma = 5, \lambda = 30, \psi = 0, \gamma = 0.1","\theta = " + thetas(i)});
    else
        title("\theta = "+ thetas(i))
    end  
end

for i = 1:length(gammas)
    filterPairs = createGabor( sigma, theta, lambda, psi, gammas(i) );
    subplot(3,5,i+10); imshow(filterPairs(:,:,1));  
    if(i == 3)
        title({"Varying \gamma and constant \sigma = 5, \theta = \lambda = 30, \psi = 0","\theta = " + thetas(i)});
    else
        title("\gamma = "+ gammas(i))
    end
end