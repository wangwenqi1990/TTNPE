function [train_data, train_label, test_data, test_label] =get_data(Dataset, images, labels, class, class_size, noise)
    train_idx   = [];
    test_idx    = [];
    for i = 1: class
        idlist    = find(labels==i);
        if i==10 && strcmp(Dataset,'MNIST')
            idlist    = find(labels==0);
        end
        tplist    = randsample(idlist, class_size);
        train_idx = [train_idx, tplist];
        test_idx  = [test_idx, setdiff(idlist, tplist)];
    end
    train_data  = images(:, train_idx);
    train_label = labels(train_idx);
    test_data   = images(:, test_idx);
    test_label  = labels(test_idx);            
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % add noise to data
    train_data = train_data + noise * randn(size(train_data));
    test_data  = test_data  + noise * randn(size(test_data) );
end