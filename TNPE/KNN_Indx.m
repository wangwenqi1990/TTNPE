function Indx_Matrix = KNN_Indx(train_data,K)
    n = size(train_data);
    N = n(end);
    M = tens2mat(train_data, 1:length(n)-1, length(n));
    IDX = knnsearch(M', M','dist','euclidean', 'K', K+1);
    IDX = IDX(:, 2:end);
    Indx_Matrix = zeros(N, N);
    for i=1:N
        Indx_Matrix(i, IDX(i,:)) = 1;
    end
end