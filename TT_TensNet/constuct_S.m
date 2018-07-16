function S = constuct_S(M, L, K, epsilon)
    % M: d * N   (features_dim * data amount)
    % L: 1 * N   (labels       * data amount)

    [idx, dist]= knnsearch(M', M','K', K+1, 'Distance', 'euclidean');
    idx = idx(:, 2:end); 
    dist = dist(:, 2:end);
    
    N = size(M, 2);
    S = zeros(N, N);
    for i=1:N
        S(i, idx(i,:)) = exp(-dist(i,:).*dist(i,:)/epsilon) + 10^-8; % add small noise to avoid singularlity
    end
    S = S + S';         %   Symmetric the graph
    
    %   Label Information
    if false
        Label_M = nan(N,N);
        for i=1:N
            for j=1:N
                Label_M(i,j) = (L(i) == L(j));
            end
        end
        S = S.* Label_M;
    end
    
    %   Normalize such that row sum is 1;
    S = S./kron(ones(1, N),(sum(S'))');
end