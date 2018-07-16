function [dim, core] = Dim_Tucker(Ui)
    % dim stores the linear transformation sum(I*r -1/2r(r+1));
    % core stores r1 *... * rn
    % Ui{i}:  ri * ni
    n = length(Ui);
    dim =0;
    core =1;
    for i=1:n
        dim = dim + numel(Ui{i});
        core = core * size(Ui{i}, 1);
    end
end