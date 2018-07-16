function [images, labels,K_list,tau_list,tensor_shape,classsize_list,class] = load_data(Dataset)
% (Input)   Dataset:        a string a a dataset
% (Output)  images:         d * N   vectorized dataset 
%           labels:         1 * N   labels for each data  
%           K_list          1 * k1 list, each entry is the amount of neibors
%                           to build the graph and conduct KNN classification
%           tau_list        1 * k2 list, each entry is the thresholding parameter for TTNPE
%           tensor_shape    the dimension for dataset dependent reshaped tensors
%           classsize_list  a list of scaler, and each is the amount of data from each class   
%           class           a scaler that is the amount of class;
if strcmp(Dataset,'MNIST')
    % MNIST
    load MNIST.mat
    labels = labels';
    clear idx;
    K_list          = [1,3,5,7];
    tau_list        = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0]; %threshold parameter for TTNPE
    tensor_shape    = [4,7,4,7];% the dimension for dataset dependent reshaped tensors
    classsize_list  = 600;   
    class           = 2;
elseif strcmp(Dataset, 'Finance')
    % Finance
    load Finance.mat
    images = reshape(Data, [1000, 400 * 2]);
    labels = [ones(400, 1); ones(400,1) *2]';
    clear Data;
    K_list          = [1,3,5,7,15,31];
    tau_list        = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0]; %threshold parameter for TTNPE
    tensor_shape    = [10,10,10];% the dimension for dataset dependent reshaped tensors
    classsize_list  = 300;   
    class           = 2;
elseif strcmp(Dataset,'Weizmann')
    % Weizman
    load WeizmanData.mat
    f = 1/8;
    Data_old = Data;
    Data = nan(size(Data,1)*f, size(Data,2)*f, size(Data,3), size(Data,4));
    for i = 1:size(Data,3)
        for j= 1: size(Data, 4);
            Data(:,:, i, j) = imresize(Data_old(:,:,i,j), f);
        end
    end
    img_size    = size(Data);
    images  = reshape(Data, [img_size(1) * img_size(2),img_size(3) * img_size(4)]);
    labels  = kron(1:img_size(4), ones(1, img_size(3)));
    clear img_size f i j namelists Data_old Data images_all labels_all;
    K_list          = [10, 50, 100]; % neibors to build the graph and classify
    tau_list        = [0.2:-0.04:0.04, 0.03:-0.002:0]; %threshold parameter for TTNPE
    tensor_shape    = [4,4,4,4,11];% the dimension for dataset dependent reshaped tensors
    classsize_list  = 20;   
    class           = 10;
else
    disp('Error in loading data!');
end
end