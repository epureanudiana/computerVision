function ab = affineTrans(Ia, Ib, x_best)
    m = [x_best(1), x_best(2); x_best(3), x_best(4)];
    t = [x_best(5); x_best(6)];
    inverse = inv(m);

    cols = size(Ia, 2);
    rows = size(Ia, 1);


    for x = 1:cols
        for y = 1:rows
            point = round(m*[x; y] +t);
            if point(1)>0 && point(2)>0 && point(1) <= size(Ib,2) && point(2)<=size(Ib,1)
                ab(point(2), point(1)) = Ia(y, x);
            end
        end
    end
end