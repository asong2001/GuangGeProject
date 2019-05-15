clc;
clear;
close all;

% R1 = zeros(1,100);
% R2 = R1;
% R3 = R1;

for k = 1:1
        figure(k);
        filename1=['E:\8-2019春季学期\CS design\wifiCSI\csidata\lab data\', num2str(k),'.dat'];
        filename2=['E:\8-2019春季学期\CS design\wifiCSI\csidata\lab data\wk', num2str(3),'.dat'];

        figure(k);
        subplot(211);
        [~, csi_ori]=getbatchdata(filename1,0,100);
        csi_ori_tx1 = squeeze(csi_ori(1,:,:));
        csi_ori_tx2 = squeeze(csi_ori(2,:,:));
        csi_ori_tx3 = squeeze(csi_ori(3,:,:));
        subplot(212);
        [~, csi_wk]=getbatchdata(filename2,0,100);
        csi_wk_tx1 = squeeze(csi_wk(1,:,:));
        csi_wk_tx2 = squeeze(csi_wk(2,:,:));
        csi_wk_tx3 = squeeze(csi_wk(3,:,:));
        
%         for sub = 1:100
%                 R= corrcoef(csi_ori_tx1(:,sub), csi_wk_tx1(:,sub));
%                 R1(k,sub) = abs(R(1,2));
%                 R= corrcoef(csi_ori_tx2(:,sub), csi_wk_tx2(:,sub));
%                 R2(k,sub) = abs(R(1,2));
%                 R= corrcoef(csi_ori_tx3(:,sub), csi_wk_tx3(:,sub));
%                 R3(k,sub) = abs(R(1,2));
%         end

R= corrcoef(mean(csi_ori_tx1,1), mean(csi_wk_tx1,1));
R1(k) = abs(R(1,2));
R= corrcoef(mean(csi_ori_tx2,1), mean(csi_wk_tx2,1));
R2(k) = abs(R(1,2));
R= corrcoef(mean(csi_ori_tx3,1), mean(csi_wk_tx3,1));
R3(k) = abs(R(1,2));

end
