function [best_x, inliers] = RANSAC(f1, f2, matches, P, N)

radius = 10;
max_inliers = 0;

for n = 1:N
    
    total_of_columns = size(matches, 2);
    random_columns_indices = randperm(total_of_columns, P);
    p_random_indices = matches(:, random_columns_indices);
    a_indices =  p_random_indices(1, :);
    b_indices = p_random_indices(2, :);
    
    A = ones(2*P, 6);
    b = ones(2*P, 1);
    
    rows1 = f1(1, a_indices);
    cols1 = f1(2, a_indices);
    rows2 = f2(1, b_indices);
    cols2 = f2(2, b_indices);
    
    for i=1:P
        A(2*i-1:2*i,:) = [rows1(i) cols1(i) 0 0 1 0; 0 0 rows1(i) cols1(i) 0 1];
        b(2*i-1:2*i) = [rows2(i); cols2(i)];
    end
    
    x = pinv(A)*b;
    
    m = [x(1), x(2); x(3), x(4)];
    t = [x(5); x(6)];
    
    all_rows1 = f1(1, matches(1, :));
    all_cols1 = f1(2, matches(1, :));
    all_rows2 = f2(1, matches(2, :));
    all_cols2 = f2(2, matches(2, :));
    
    transformed = m*[all_rows1; all_cols1] + t;
    
    inliers_outliers = ((all_rows2 - transformed(1, :)).^2 + (all_cols2 - transformed(2, :)).^2) < radius^2;
    inliers_count  = sum(inliers_outliers(:) == 1);
    
    if (inliers_count > max_inliers)
        max_inliers = inliers_count;
        inliers_indices = find(inliers_outliers);
        inliers = [f1(1, inliers_indices); f1(2,inliers_indices); ...
            f2(1, inliers_indices); f2(2, inliers_indices)];
        best_x = x;
    end
    
end

end