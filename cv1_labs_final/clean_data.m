% only keep images and labels that are corresponding to
% class of airplane, bird, ship, horse, car
function [X_train, y_train, X_test, y_test] = clean_data(train_data, test_data) 

    X_train = zeros(2500, 27648);
    y_train = zeros(2500, 1);
    X_test = zeros(4000, 27648);
    y_test = zeros(4000, 1);
    
    labels = [1,2,3,7,9];
    train_rows = size(train_data.X, 1);
    test_rows = size(test_data.X, 1);
    
    i = 1;
    for image = 1 : train_rows
        if ismember(train_data.y(image), labels)
            X_train(i, :) =  train_data.X(image, :);
            y_train(i, :) = train_data.y(image);
            i = i + 1;
        end    
    end 
    
    i = 1;
    for image = 1 : test_rows
        if ismember(test_data.y(image), labels)
            X_test(i, :) = test_data.X(image, :);
            y_test(i, :) = test_data.y(image);
            i = i + 1;
        end    
    end    
    
    X_train = uint8(X_train);
    X_test = uint8(X_test);
end 