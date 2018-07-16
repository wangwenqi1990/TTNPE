function dim=Dim_TT(Ui)
    % On manifolds of tensors of fixed TT-Rank Page 17
    % compuate dimensionliaty of TT subspace
    n = length(Ui);
    dim=0;
    for i=1:n
        [r1, I1, r2] = size(Ui{i});
        dim = dim + r1 * I1 * r2 - r2 *r2;
    end
end