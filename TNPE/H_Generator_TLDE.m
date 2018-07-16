function [H1, H2] = H_Generator_TLDE(Y, S, S_p)
    
    N = size(S, 1);
    dim = size(Y(:,:, 1),1);
    
    H1 = zeros(dim, dim);
    H2 = zeros(dim, dim);
    for i=1:N
        for j=1:N
            if (S(i,j) ~=0)
                H1 = H1 + S(i, j) * (Y(:,:, i) - Y(:,:, j)) * (Y(:,:, i) - Y(:,:, j))';
            end
            
            if (S_p(i,j) ~= 0)
                H2 = H2 + S_p(i, j) * (Y(:,:, i) - Y(:,:, j)) * (Y(:,:, i) - Y(:,:, j))';
            end
        end
    end

end