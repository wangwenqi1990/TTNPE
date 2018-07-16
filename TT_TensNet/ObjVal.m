function f=ObjVal(Z, Ui, n)
    T_all = merge_tensor(Ui);
    f = trace(wwq_tensordot(wwq_tensordot(T_all, Z, 1:n, 1:n), T_all, 2:n+1, 1:n));
end