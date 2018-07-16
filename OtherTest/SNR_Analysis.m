%% MNIST SNR analysis
clear all; clc; close all;
load MNIST
select = images(:,[find(labels==1);find(labels==2)]);%selected image
variance = nan(size(select,2),1);
for i=1:size(select,2)
    variance(i)=var(select(:,i));
end
%figure();plot(variance);
variance_mean = mean(variance);
P5=sqrt(variance_mean/(10^(5/10)));
P10=sqrt(variance_mean/(10^(10/10)));
P15=sqrt(variance_mean/(10^(15/10)));
P20=sqrt(variance_mean/(10^(20/10)));

figure()
subplot(1,5,1);imshow(reshape(select(:,1), [28,28]));title('noiseless');
subplot(1,5,2);imshow(reshape(select(:,1)+0.0284*randn(784,1), [28,28]));title('20db');
subplot(1,5,3);imshow(reshape(select(:,1)+0.0505*randn(784,1), [28,28]));title('15db');
subplot(1,5,4);imshow(reshape(select(:,1)+0.0898*randn(784,1), [28,28]));title('10db');
subplot(1,5,5);imshow(reshape(select(:,1)+0.1597*randn(784,1), [28,28]));title('5db');

%% Weizmann SNR analysis
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
select = images(:,[find(labels==1);find(labels==2);find(labels==3);find(labels==4);find(labels==5);...
    find(labels==6);find(labels==7);find(labels==8);find(labels==9);find(labels==10);]);%selected image
variance = nan(size(select,2),1);
for i=1:size(select,2)
    variance(i)=var(select(:,i));
end
%figure();plot(variance);
variance_mean = mean(variance);
P5=sqrt(variance_mean/(10^(5/10)));
P10=sqrt(variance_mean/(10^(10/10)));
P15=sqrt(variance_mean/(10^(15/10)));
P20=sqrt(variance_mean/(10^(20/10)));

figure()
subplot(1,5,1);imshow(uint8(reshape(select(:,1), [64,44])));title('noiseless');
subplot(1,5,2);imshow(uint8(reshape(select(:,1)+4.7356*randn(64*44,1), [64,44])));title('20db');
subplot(1,5,3);imshow(uint8(reshape(select(:,1)+8.4034*randn(64*44,1), [64,44])));title('15db');
subplot(1,5,4);imshow(uint8(reshape(select(:,1)+14.9437*randn(64*44,1), [64,44])));title('10db');
subplot(1,5,5);imshow(uint8(reshape(select(:,1)+26.5740*randn(64*44,1), [64,44])));title('5db');









