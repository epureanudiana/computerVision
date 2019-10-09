function[best_x] = RANSAC(f1, f2, matches, P, N)

P = 20;
max_inliers = 0;
radius = 10;

for n = 1:N
        
    matches_perm = randperm(size(matches,2)) ;
    subset_matches = matches(:, matches_perm(1:P)) ;
    
    rows1 = f1(1,subset_matches(1,:)) ;
    rows2 = f2(1,subset_matches(2,:)) ;
    cols1 = f1(2,subset_matches(1,:)) ;
    cols2 = f2(2,subset_matches(2,:)) ;
    
    A = zeros(2*P, 6);
    b = zeros(2*P, 1);
    
    for i=1:P
        A(2*i-1:2*i,:) = [rows1(i) cols1(i) 0 0 1 0; 0 0 rows1(i) cols1(i) 0 1];
        b(2*i-1:2*i) = [rows2(i); cols2(i)];
    end
    
    x = pinv(A)*b;
    m = [x(1) x(2) ; x(3) x(4)];
    t = [x(5) ; x(6)];
    new_im = m * [rows1 ; cols1] + t;
    
    inliers = 0;
    for i = 1: size(rows1,2)
        if (((new_im(1,i)-rows2(i))^2+(new_im(2, i)-cols2(i))^2) < radius^2)
            inliers = inliers + 1;
        end
    end
    
    if inliers > max_inliers
        max_inliers = inliers;
        best_A = A;
        best_t = t;
        best_x = x;
    end
end
end