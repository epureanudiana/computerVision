run('./vlfeat-0.9.21/toolbox/vl_setup')
 Ia = imread('boat1.pgm');
 Ib = imread('boat2.pgm');

[fa, fb, matches, scores] = keypoint_matching(Ia, Ib);

[x_best, inliers] = RANSAC(fa, fb, matches, 10);

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

m = [x_best(1), x_best(2); x_best(3), x_best(4)];
t = [x_best(5); x_best(6)];
inverse = inv(m);

cols = size(Ia, 2);
rows = size(Ia, 1);

%%%%%% BOAT1 to BOAT2 %%%%%%%

for x = 1:cols
    for y = 1:rows
        point = round(m*[x; y] +t);
        if point(1)>0 && point(2)>0 && point(1) <= size(Ib,2) && point(2)<=size(Ib,1)
            ab(point(2), point(1)) = Ia(y, x);
        end
    end
end
%%%%%% END BOAT1 to BOAT2 %%%%%%%

%%%%%% BOAT2 to BOAT1 %%%%%%%

for x = 1:cols
    for y = 1:rows
        inverse_point = round(inverse * ([x; y] - t));
        if inverse_point(2)> 0 && inverse_point(1) > 0 &&  ...
            inverse_point(1)<=size(Ia,2) && inverse_point(2)<=size(Ia,1)
            ba(inverse_point(2), inverse_point(1)) = Ib(y, x);
        end
    end
end

%%%%%% END BOAT2 to BOAT1 %%%%%%%

figure();
imshow(padarray(ba,0)) ;
title("Figure boat2 transformed into figure boat1 with computed coordinates");
figure();
imshow(padarray(ab,0)) ;
title("Figure boat1 transformed into figure boat2 with computed coordinates");
