close all;
iClass=1;
figure();
hold on;
fig=gcf;
set(findall(fig,'-property','FontSize'),'FontSize',28)
set(findall(fig,'-property','FontName'),'FontName','Times New Roman')
axis([0 1 -0.8 0]);
xlabel('Compression Ratio');
ylabel('Classification Error(log10)');
%% Noiseless
tau_list=[0.2:-0.04:0.04, 0.03:-0.002:0]; classsize_list=20; repeats=5; file_num=1; noise=0; Dataset='Weizmann'; K=10;tensor_shape=[4,4,4,4,11];
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
scatter(1, log10(mean(ResErr(4,:, iClass))), 'k*');
ResStor(find(ResStor>1))=1;
j=3;plot(ResStor(j,[1:5,9,11],iClass), log10(ResErr(j,[1:5,9,11],iClass)), 'b-*','linewidth', 3);
j=1;plot(ResStor(j,:,iClass), log10(ResErr(j,:,iClass)), 'r-*','linewidth', 3); 
%K = 100;
%legend(['KNN(K=' num2str(K) ')'],['TNPE(K=' num2str(K) ')'],['TTNPE-ATN(K=' num2str(K) ')']);
%saveas(gcf, ['Weizmann' num2str(K) '.pdf']);

%% 20db
tau_list=[0.2:-0.04:0.04, 0.03:-0.002:0]; classsize_list=20; repeats=5; file_num=5; noise=4.7256; Dataset='Weizmann'; K=10;tensor_shape=[4,4,4,4,11];
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
%scatter(1, log10(mean(ResErr(4,:, iClass))), 'kx');

%% 15DB
tau_list=[0.2:-0.04:0.04, 0.03:-0.002:0]; classsize_list=20; repeats=5; file_num=4; noise=8.4034; Dataset='Weizmann'; K=10;tensor_shape=[4,4,4,4,11];
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
tau_list=[0.2:-0.04:0.04, 0.03:-0.002:0]; classsize_list=20; repeats=5; file_num=3; noise=14.9437; Dataset='Weizmann'; K=10;tensor_shape=[4,4,4,4,11];
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
tau_list=[0.2:-0.04:0.04, 0.03:-0.002:0]; classsize_list=20; repeats=5; file_num=2; noise=26.5740; Dataset='Weizmann'; K=10;tensor_shape=[4,4,4,4,11];
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
K = 10;
AX=legend(4,{['KNN'],['TNPE'],['TTNPE-ATN'],...
    ['TTNPE-ATN(20db)'],...%['(20db)TNPE(K=' num2str(K) ')'],['(20db)KNN(K=' num2str(K) ')'],...
    ['TTNPE-ATN(15db)'],...%['(15db)TNPE(K=' num2str(K) ')'],['(15db)KNN(K=' num2str(K) ')'],...
    ['TTNPE-ATN(10db)'],...%['(10db)TNPE(K=' num2str(K) ')'],['(10db)KNN(K=' num2str(K) ')'],...
    ['TTNPE-ATN( 5db)']},'NorthWest');%['(5db)TNPE(K=' num2str(K) ')'],['(5db)KNN(K=' num2str(K) ')']);
AX.FontSize = 18;

 saveas(gcf, ['WeizmannNoise' num2str(K) '.pdf']);
 
