function [stitched_image] = stitch(left, right)
[hl, wl, ~] = size(left);
[hr, wr, ~] = size(right);

[fa, fb, matches, ~] = keypoint_matching(rgb2gray(left), rgb2gray(right));
[x, ~] = RANSAC(fa, fb, matches, 5);

M = [x(1), x(2); x(3), x(4)];
T = [x(5); x(6)];

% transform the corners of the right image
corners = [M * [1; 1] + T, M * [wr; 1] + T, M * [1; hr] + T, M * [wr; hr] + T]';

% get the edges of the stitched image
top_edge = max(ceil(max(corners(:, 2))), hl);
bottom_edge = min(floor(min(corners(:, 2))), 1);
left_edge = min(floor(min(corners(:, 1))), 1);
right_edge = max(ceil(max(corners(:, 1))), wl);

% estimate the size
hs = top_edge - bottom_edge + 1;
ws = right_edge - left_edge + 1;

%% MODIFY
% transform right image
imwarp_transf = [x(1), x(2), 0;
    x(3), x(4), 0;
    x(5), x(6), 1];
warped = imwarp(right, affine2d(imwarp_transf));

%%
% stitch the images
stitched_image = zeros([hs, ws, 3], 'like', left);
stitched_image(1:hl, 1:wl, :) = left;

end
