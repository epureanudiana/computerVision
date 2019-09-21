function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
[h,w,~] = size(normals);

p = zeros(h,w);
q = zeros(h,w);
SE = zeros(h,w);

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

p = normals(:, :, 1) ./ normals(:, :, 3);
q = normals(:, :, 2) ./ normals(:, :, 3);
% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE
% ========================================================================
p1 = [p zeros(size(p,1), 1)];
q1 = [q; zeros(1, size(q, 2))];

SE = (diff(p1, 1, 2) - diff(q1, 1, 1)).^2;

end

