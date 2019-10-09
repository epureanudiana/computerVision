function ba = inv_affineTrans(Ia, Ib, x_best)
    m = [x_best(1), x_best(2); x_best(3), x_best(4)];
    t = [x_best(5); x_best(6)];
    inverse = inv(m);

    cols = size(Ia, 2);
    rows = size(Ia, 1);
    
    for x = 1:cols
        for y = 1:rows
            inverse_point = round(inverse * ([x; y] - t));
            if inverse_point(2)> 0 && inverse_point(1) > 0 &&  ...
                inverse_point(1)<=size(Ia,2) && inverse_point(2)<=size(Ia,1)
                ba(inverse_point(2), inverse_point(1)) = Ib(y, x);
            end
        end
    end

end