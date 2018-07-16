load Ui
shapeZ=size(Z);
Mz = reshape(Z, [sqrt(prod(size(Z))),sqrt(prod(size(Z)))] );
Z =  reshape(Mz + Mz', shapeZ);
n = length(Ui);
T_all = merge_tensor(Ui);
f_old= trace(wwq_tensordot(wwq_tensordot(T_all, Z, 1:n, 1:n), T_all, 2:n+1, 1:n));


delta = 10^-10;

for p=1:10
for k=1:5
    Gk = reshape(grident_Uk(Ui, Z, k), size(Ui{k}));
    Ui{k} = Ui{k} - delta * Gk;
    T_all = merge_tensor(Ui);
    f_new = trace(wwq_tensordot(wwq_tensordot(T_all, Z, 1:n, 1:n), T_all, 2:n+1, 1:n));
    disp(f_new-f_old);
    f_old = f_new;
end
disp(['*****************************', num2str(f_old), '***************']);
end