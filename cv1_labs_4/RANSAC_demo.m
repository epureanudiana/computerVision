run('./vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

[f1, f2, matches, scores] = keypoint_matching(im1, im2);
[x, inliers] =  RANSAC(f1, f2, matches, 5);
