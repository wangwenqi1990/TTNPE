close all;
iClass=1;
figure();
hold on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',28)
set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
xlabel('Compression Ratio');
ylabel('Classification Error(log10)');
%% Noiseless
tau_list = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0];classsize_list=600;repeats=5;file_num=1;noise=0;Dataset='MNIST';K=1;tensor_shape=[4,7,4,7];
name_path=strcat('Res_',Dataset);
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
load(tpname);
ResStor(find(ResStor>1))=1;
scatter(1, log10(ResErr(4,end,iClass)), 'k*');
tp =log10(ResErr(4,end,iClass));
j=3;plot([0.03,ResStor(j,:,iClass)], [-0.3,log10(ResErr(j,:,iClass))], 'b-*','linewidth', 3);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r-*','linewidth', 3); 
K = 7;
legend(['KNN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')'],['TTNPE-ATN(K=' num2str(K) ')']);
scatter(1, tp, 'k*');
saveas(gcf, ['MNIST' num2str(K) '.pdf']);

%% 20db
tau_list = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0];classsize_list=600;repeats=5;file_num=5;noise=0.0284;Dataset='MNIST';K=1;tensor_shape=[4,7,4,7];
name_path=strcat('Res_',Dataset);
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
load(tpname);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r-.','linewidth', 3); 
%j=3;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'b-.x','linewidth', 3); 
%scatter(1, log10(ResErr(4,end, iClass)), 'kx');

%% 15DB
tau_list = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0];classsize_list=600;repeats=5;file_num=4;noise=0.0505;Dataset='MNIST';K=1;tensor_shape=[4,7,4,7];
name_path=strcat('Res_',Dataset);
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
load(tpname);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r--','linewidth', 3); 
%j=3;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'b--o','linewidth', 3); 
%scatter(1, log10(mean(ResErr(4,:, iClass))), 'ko');

%% 10 DB
tau_list = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0];classsize_list=600;repeats=5;file_num=3;noise=0.0898;Dataset='MNIST';K=1;tensor_shape=[4,7,4,7];
name_path=strcat('Res_',Dataset);
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
load(tpname);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r:','linewidth', 3); 
%j=3;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'b:s','linewidth', 3); 
%scatter(1, log10(mean(ResErr(4,:, iClass))), 'ks');

%% 5db
tau_list = [0.4:-0.04:0.08, 0.06:-0.02:0.02, 0.015:-0.003:0.001,0];classsize_list=600;repeats=5;file_num=2;noise=0.1597;Dataset='MNIST';K=1;tensor_shape=[4,7,4,7];
name_path=strcat('Res_',Dataset);
name_shape='';
for i=1:length(tensor_shape)
    name_shape=strcat(name_shape, int2str(tensor_shape(i)));
end
tpname = [name_path, '/', Dataset, '_noise' num2str(noise),...
        '_K', num2str(K),...
        '_Tr', num2str(classsize_list(iClass)),...
        '_shape',name_shape,...
        '.mat'];
load(tpname);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r--','linewidth', 3); 
%j=3;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'b--d','linewidth', 3); 
%scatter(1, log10(mean(ResErr(4,:, iClass))), 'kd');

%%
% legend
K = 3;
AX=legend(['KNN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')'],['TTNPE-ATN(K=' num2str(K) ')'],...
    ['(20db)TTNPE-ATN(K=' num2str(K) ')'],...%['(20db)TNPE(K=' num2str(K) ')'],['(20db)KNN(K=' num2str(K) ')'],...
    ['(15db)TTNPE-ATN(K=' num2str(K) ')'],...%['(15db)TNPE(K=' num2str(K) ')'],['(15db)KNN(K=' num2str(K) ')'],...
    ['(10db)TTNPE-ATN(K=' num2str(K) ')'],...%['(10db)TNPE(K=' num2str(K) ')'],['(10db)KNN(K=' num2str(K) ')'],...
    ['(  5db)TTNPE-ATN(K=' num2str(K) ')']);%['(5db)TNPE(K=' num2str(K) ')'],['(5db)KNN(K=' num2str(K) ')']);
AX.FontSize = 15;
scatter(1, tp, 'k*');
saveas(gcf, ['MNISTNoise' num2str(K) '.pdf']);
 
