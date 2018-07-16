function TNPE = main_TNPE(train_data, train_label, test_data,...
    test_label, tensor_shape, tau, Graph, para_TNPE,KNN)
    
    % Get the parameter
    N = size(train_data, 2);
    k = length(tensor_shape);
    r = nan(k, 1);
    T = reshape(train_data, [tensor_shape, N]);
    
    TNPE_start = cputime;
    % construct graph
    S = constuct_S(train_data, train_label, Graph.K, Graph.epsilon);
    % Based on tau to initialize U
    U = cell(k,1);
    for i=1:k
        [u, s, v] =svd(tens2mat(T, i, setdiff(1:k+1, i)),'econ');
        s(s < tau * max(max(s)))=0;
        r(i) = length(find(s~=0));
        U{i} = zeros(r(i), tensor_shape(i));       % r_i *I_i
        U{i}(eye(r(i))==1) =1;
        T = mat2tens(u*s*v', [tensor_shape, N], i, setdiff(1:k+1, i));
    end
    
    % update U
    T = reshape(train_data, [tensor_shape, N]);
    for t=1:para_TNPE.Tmax
        %%
        U_tp = U;
        
        % solve for each Ui
        for f=1:k
            U_tp{f} = eye(size(U_tp{f}, 2));
            y = Tucker_U2Y(U_tp, T);
            Y = tens2mat(y, f, setdiff(1:k+1, f));
            Y = reshape(Y, [size(Y,1), size(Y,2)/N, N]);
            [H1, H2 ]= H_Generator(Y, S);
            [V, ~] = eig(H1, H2);
            U_tp{f}= V(:, 1:r(f))';
        end
        
        err = diffU(U_tp, U);
        if (err <= para_TNPE.toler)
            break;
        else
            U = U_tp;
        end
        
        if (para_TNPE.show==1)
            disp(['At iteration ' num2str(t) ', the error is ' num2str(err)]);   
        end
    end
    clear U_tp;
    TNPE.time_subspace = cputime-TNPE_start;
    
    TNPE_start = cputime;
    % Embeded Data
    B_train = reshape(Tucker_U2Y(U, reshape(train_data, [tensor_shape, N])), [prod(r), N]);
    B_test  = reshape(Tucker_U2Y(U, reshape(test_data,  [tensor_shape, size(test_data,2)])), [prod(r), size(test_data,2)]);
    TNPE.time_embedding = cputime-TNPE_start;
    
    TNPE_start = cputime;
    [TNPE.PreLabel, TNPE.PreErr] = Classfier_KNN(B_train, train_label, B_test, test_label, KNN.K);
    TNPE.time_classify = cputime-TNPE_start;
    
    TNPE.Ui = U;
    [ManiFold_TNPE, core_TNPE] = Dim_Tucker(U);
    TNPE.Storage = size(train_data,2) * core_TNPE + ManiFold_TNPE;
end
