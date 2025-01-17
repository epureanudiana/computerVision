function[fa, fb, matches, scores] = keypoint_matching(Ia, Ib)

%single precision
Ia = im2single(Ia) ;
Ib = im2single(Ib) ;

%frames+descriptors
[fa, da] = vl_sift(Ia);
[fb, db] = vl_sift(Ib);
[matches, scores] = vl_ubcmatch(da, db) ;
end




