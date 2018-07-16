function [predict_label_KNN, error_predict] = Classfier_KNN(train_data, train_label, test_data, test_label, K_list)
    % Given training data/label and testing data/label, and a list of K
    % neighbors, return the predicted labels and the predicted errors.
    N = length(K_list);
    predict_label_KNN = nan(size(test_data, 2), N);
    error_predict     = nan(N,1);
    for i = 1: length(K_list)
        predict_label_KNN(:,i) = KNN_Classifier(train_data, train_label, test_data,  K_list(i));
        error_predict(i) = error_function(predict_label_KNN(:,i), test_label);
    end
end

function predict_label = KNN_Classifier(train_data, train_label, test_data,  K)
    KNN = fitcknn(train_data', train_label', 'NumNeighbors', K);
    predict_label = predict(KNN, test_data');
end

function Err = error_function(preLabel, trueLabel)
    n= max(size(preLabel));
    count=0;
    for i=1:n
        count = count+(preLabel(i)==trueLabel(i));
    end
    Err = 1-count/n;
end