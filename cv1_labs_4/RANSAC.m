function [best_x, inliers] = RANSAC(fa, fb, matches, P)

N = 100;
P = 10;
max_inliers = 0;

for i = 1:N
    
    total_of_columns = size(matches, 2);
    random_columns_indices = randperm(total_of_columns, P);
    p_random_indices = matches(:, random_columns_indices);
    a_indices =  p_random_indices(1, :);
    b_indices = p_random_indices(2, :);
    
    A = ones(2*P, 6);
    b = ones(2*P, 1);
    
    xa_values = fa(1, a_indices);
    ya_values = fa(2, a_indices);
    xb_values = fb(1, b_indices);
    yb_values = fb(2, b_indices);
    
    for j = 1:P
        
        A(2*j-1, :) = [xa_values(j), ya_values(j), 0, 0, 1, 0 ];
        A(2*j, :) = [0, 0, xa_values(j), ya_values(j), 0, 1];
        b(2*j-1, 1) = xb_values(j);
        b(2*j) = yb_values(j);
        
    end    
    
    x = pinv(A)*b;
    
    m = [x(1), x(2); x(3), x(4)];
    t = [x(5); x(6)];
      
    xa_all = fa(1, matches(1, :));
    ya_all = fa(2, matches(1, :));
    xb_all = fb(1, matches(2, :));
    yb_all = fb(2, matches(2, :));  
    
    transformed = m*[xa_all; ya_all] + t;
    xa_transformed = transformed(1, :);
    ya_transformed = transformed(2, :);
      
    inliers_outliers = ((xb_all - xa_transformed).^2 + (yb_all - ya_transformed).^2) < 100;
    inliers_count  = sum(inliers_outliers(:) == 1);
    
    if (inliers_count > max_inliers)
        max_inliers = inliers_count;
        inliers_indices = find(inliers_outliers);
        inliers = [fa(1, inliers_indices); fa(2,inliers_indices); ...
        fb(1, inliers_indices); fb(2, inliers_indices)];
        best_x = x;
    end
    
end 

end