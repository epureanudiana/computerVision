run('./vlfeat-0.9.21/toolbox/vl_setup')
im1 = imread('boat1.pgm');
im2 = imread('boat2.pgm');

[f1, f2, matches, scores] = keypoint_matching(im1, im2);

figure() ; 
imshow(cat(2, im1, im2)) ;

matches_perm = randperm(size(matches,2)) ;
subset_matches = matches(:, matches_perm(1:10)) ;

offset = size(im1,2);

x1 = f1(1,subset_matches(1,:)) ;
x2 = f2(1,subset_matches(2,:)) + offset ;
y1 = f1(2,subset_matches(1,:)) ;
y2 = f2(2,subset_matches(2,:)) ;

hold on;

h = line([x1 ; x2], [y1 ; y2]) ;

vl_plotframe(f1(:,subset_matches(1,:))) ;
f2(1,:) = f2(1,:) + size(im1,2) ;
vl_plotframe(f2(:,subset_matches(2,:))) ;
axis image off ;