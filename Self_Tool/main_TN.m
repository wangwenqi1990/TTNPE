function TN=main_TN(train_data, train_label, ...
    test_data,test_label, tensor_shape, tau, Graph, para_TN,KNN)
    % train_data  & test_data:  (I1*...*In) * N matrix
    % train_label & test_label: 1 * N
    
    % unitary solver parameter
    opts.record = 0;        
    opts.mxitr  = 1000;
    opts.gtol   = 1e-5;
    opts.xtol   = 1e-5;
    opts.ftol   = 1e-8;
    opts.tau    = 1e-3;
    
    % read parameter
    n   = length(tensor_shape);     % tensor data order
    N   = size(train_data, 2);      % train data size
    
    % Initialize Ui
    Ui = U2Ui_tau(reshape(train_data, [tensor_shape, N]), tau); % U1, ....,Un, A 
    % Ui = U2Ui_tau_thre(reshape(train_data, [tensor_shape, N]), tau, 100);
    Ui = Ui(1:n);                                               % U1,..., Un
    
    % Construct Graph S
    S = constuct_S(train_data, train_label, Graph.K, Graph.epsilon);
    
    % Construct Y, and thus Z 
    Y = train_data * ( eye(size(train_data, 2)) - S');
    Z = reshape(Y * Y', [tensor_shape, tensor_shape]);
    
    % Solve by TT_TensNet
    [TN.Ui, ~]    = TensNet_Solver(Ui, Z, para_TN, opts);
    disp(['The objval is ', num2str(ObjVal(Z, TN.Ui, n)), ' by TT_TensNet']);
    Subspace_TT         = tens2mat(merge_tensor(TN.Ui),1:n, n+1);
    train_proj          = Subspace_TT' * train_data;
    test_proj           = Subspace_TT' * test_data;
    [TN.PreLabel, TN.PreErr] = Classfier_KNN(train_proj, train_label, test_proj, test_label, KNN.K);
    TN.Storage  = Dim_TT(TN.Ui) + size(TN.Ui{end},3) * size(train_data, 2);
end