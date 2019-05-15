%training
clear all
close all
clc

for i=1:9
        batchdata=[];
        filename=['E:\8-2019����ѧ��\CS design\wifiCSI\csidata\lab data\', num2str(i),'.dat'];
        if(exist(filename)==2)
            %������ÿ��������Ϊpackage��������
%             for an=1:3
%                 batchdata=getonebatchdata(filename,100,900,an);
%                 batchdata=[batchdata 
%                     batchdatatmp];
%             end
            batchdata=getbatchdata(filename,0,100);
%             batchdata=getonebatchdata(filename,100,900,an);
            save batchdata batchdata;
            fprintf(1,'training data %s prepared', filename);
           
            [numcases numdims numbatches]=size(batchdata);
            maxepoch=10; %In the Science paper we use maxepoch=50, but it works just fine. 
%             numhid=300; numpen=150; numpen2=100; numopen=50;
%             numhid=200; numpen=100; numpen2=50; numopen=20;
%             numhid=70; numpen=50; numpen2=30; numopen=15;
            numhid=500; numpen=300; numpen2=150; numopen=50;

            fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
            restart=1;
            rbm;
            hidrecbiases=hidbiases; 
            save mnistvh vishid hidrecbiases visbiases;
            
            fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
            batchdata=batchposhidprobs;
            numhid=numpen;
            restart=1;
            rbm;
            hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
            save mnisthp hidpen penrecbiases hidgenbiases;
            
            fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
            batchdata=batchposhidprobs;
            numhid=numpen2;
            restart=1;
            rbm;
            hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
            save mnisthp2 hidpen2 penrecbiases2 hidgenbiases2;
            
            fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);
            batchdata=batchposhidprobs;
            numhid=numopen; 
            restart=1;
            rbmhidlinear;
            hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases;
            save mnistpo hidtop toprecbiases topgenbiases;
            
            fprintf(1,'training backpropagation');
            backpropagation;
%             backpropagationtest;
        end
end