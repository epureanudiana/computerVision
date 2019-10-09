run('./vlfeat-0.9.21/toolbox/vl_setup')
 Ia = imread('boat1.pgm');
 Ib = imread('boat2.pgm');

[fa, fb, matches, scores] = keypoint_matching(Ia, Ib);

[x_best] = RANSAC(fa, fb, matches, 3, 100);

%%%%%%% IMWARP %%%%%%%%%
imwarp_transf = [x_best(1), x_best(2), 0;
      x_best(3), x_best(4), 0;
      x_best(5), x_best(6), 1];
imwarp_transf_inv = inv(imwarp_transf);
imwarp_transf_inv(1, 3) = 0;
imwarp_transf_inv(2, 3) = 0;
imwarp_transf_inv(3, 3) = 1;

figure(5);
subplot(1,2,1)
imshow(imwarp(Ia,affine2d(imwarp_transf_inv)));
title("Figure boat1 to figure boat2 with imwarp");
subplot(1,2,2)
imshow(imwarp(Ib, affine2d(imwarp_transf)));
title("Figure boat2 to figure boat1 with imwarp");

%%%%%%% END IMWARP %%%%%%%%%

%transform image1 to image2
ab = affineTransf(Ia, Ib, x_best);

%transform image2 to image1
ba = inv_affineTransf(Ia, Ib, x_best);

figure();
imshow(padarray(ba,0)) ;
title("Figure boat2 transformed into figure boat1 with computed coordinates");
figure();
imshow(padarray(ab,0)) ;
title("Figure boat1 transformed into figure boat2 with computed coordinates");

%%%%% PLOT CONNECTING 10 POINTS FROM Ia to TRANSFORMED Ia %%%%%%

[f1, f2, matches, scores] = keypoint_matching(Ia, ab);

figure(20) ; 
imshow(cat(2, Ia, ab)) ;

matches_perm = randperm(size(matches,2)) ;
subset_matches = matches(:, matches_perm(1:10)) ;

offset = size(Ia,2);

x1 = f1(1,subset_matches(1,:)) ;
x2 = f2(1,subset_matches(2,:)) + offset ;
y1 = f1(2,subset_matches(1,:)) ;
y2 = f2(2,subset_matches(2,:)) ;

hold on;

h = line([x1 ; x2], [y1 ; y2]) ;

vl_plotframe(f1(:,subset_matches(1,:))) ;
f2(1,:) = f2(1,:) + size(Ia,2) ;
vl_plotframe(f2(:,subset_matches(2,:))) ;
axis image off ;

%%%%% END PLOT CONNECTING 10 POINTS FROM Ia to TRANSFORMED Ia %%%%%%