%% FACE RECOGNITION USING PCA 
%
% This program is written by Dr. Alaa ELEYAN
% If you use this program or part of it, please provide a citation for at 
% least one of the following papers:
%  
% [1] A Eleyan, H Ozkaramanli, H Demirel, Complex wavelet transform-based 
%     face recognition, Journal EURASIP Journal on Advances in Signal 
%     Processing,2008.
% [2] A Eleyan, H Demirel, Face recognition system based on PCA and 
%     feedforward neural networksComputational Intelligence and Bioinspired
%     Systems, pp. 935-942,Springer 2005.
% [3] A Eleyan, H Demirel, PCA and LDA based neural networks for human 
%     face recognition, book chapter, INTECH 2007.
% 2010
%------------------------------------------------------------------------
% Images from ORL database are in BMP format and renamed in one single 
% folder as:  
% face1.bmp  to face10.bmp for person No. 1
% face11.bmp to face20.bmp for person No. 2
% ...
% face391.bmp to face400.bmp for person No. 40.
 
% rndMtrx.mat file is generated to randomley select the required number 
% of traing images NTr per person and leave the rest 10-NTr images for test. 
% The randomaization is done 10 times before averaging the results.
clear all
clc
cd 'C:\Users\skygt\Desktop\ORL'
load rndMtrx       % for randmoly choosing training images for each person.
NP = 40;           % number of people in database
TI = 10;           % number of images per person
% NTr = 5  ;         % number of train images per person                       
RRPCA = [];        % recognition rate for PCA
% NTs = TI - NTr;    % number of test images  per person
for NTr = 1 : 9;    % change number of training images 'NTr' per person
       
for itr=1:size(rndMtrx,1)  % run the program randomly 10 times then average results.
 
%     display(sprintf('%d Train Images ... Run No.: %d',(NTr),(itr)))
    
    % Read train face images
    c=1;
    for i=1:NP
        for j=1:NTr
            im = ['face' int2str(rndMtrx(itr,(i-1)*TI+j)) '.bmp'];
            [X,MAP]=imread(im);
            x=ind2gray(X,MAP);
            Train(:,c) = x(:);%double(x(:))/norm(double(x),2);   % norm(x,2) for normalization.      
            c=c+1;
        end
    end
    clear memory
 % Read test face images
c=1;
    for i=1:NP
        for j=NTr+1:TI
            im = ['face' int2str(rndMtrx(itr,(i-1)*TI+j)) '.bmp'];
            [X,MAP]=imread(im);
            x=ind2gray(X,MAP);
            Test(:,c) = x(:);%double(x(:))/norm(double(x),2);  % norm(x,2) for normalization.
            c=c+1;        
       end
    end
  %% PCA Transform
% ====================
Av=sum(Train')'/(NP*TI);           
Avmtx=(ones(NP*NTr,1)*Av')';
clear memory
A=double(Train)-Avmtx;
clear Avmtx Train
[V,L]=eig (A'*A);
Lamda = diag(L);
clear L
[r c]=size(V);
Ld=(ones(r,1)*Lamda');
clear lamda
V=V./sqrt(Ld);  % whittening
U= A*V;
clear V Ld 
A_trn=U'*double(A);  % feature vectors for train set
clear A 
Avmtx=(ones(NP*(TI-NTr),1)*Av')';
clear Av
B=double(Test)-Avmtx;
clear Test Avmtx
A_tst=U'*double(B);  % feature vectors for test set
clear B U
    
%% NEAREST NEIGHBOR  
for i=1:NP*(TI-NTr)
    At=A_tst(:,i);
    A_temp=(ones(NP*NTr,1)*At')';
    Diff=A_temp-A_trn;
    % Euclidean Distance
    [r,c]=min(diag(sqrt(Diff'*Diff)));
    % Cosince Distance
    [r1 c1]=min(1-(sum(A_temp.*A_trn)./(sqrt(sum(A_temp.*A_temp).*sum(A_trn.*A_trn)))));
    % Manhatan Distance
    [r2 c2]=min(sum(abs(Diff)));
    mn(i)=ceil(c/NTr);      % min Distance location using Euclidean
    mn1(i)=ceil(c1/NTr);    % min Distance location using Cosince
    mn2(i)=ceil(c2/NTr);    % min Distance location using Manhatan
end
% Ground Truth
testClass = ones(TI-NTr,1)*[1:NP];
testClass=reshape(testClass,(TI-NTr)*NP,1);
% Manhatan Distance
answer=mn2';
correct = find( (testClass - answer == 0));
Mn_L1_PCA(itr)= 100*size(correct,1) / size(answer,1);
% Euclidean Distance
answer=mn';
correct = find( (testClass - answer == 0));
Euc_L2_PCA(itr)= 100*size(correct,1) / size(answer,1);
% Cosince Distance
answer=mn1';
correct = find( (testClass - answer == 0));
Cos_PCA(itr)= 100*size(correct,1) / size(answer,1);
clear mn mn1 mn2 
end
RRPCA =[RRPCA; NTr mean([Mn_L1_PCA' Euc_L2_PCA' Cos_PCA' ])];
end
%% Complete results shown as a table
display(sprintf('\n\n%-15s %-12s %-12s %-12s\n','#Train Images' , 'Manhattan' ,'Euclidean ', 'Cosine'))
for i = 1 : NTr
   display(sprintf('%-15d %-12f %-12f %-12f',RRPCA(i,1),RRPCA(i,2),RRPCA(i,3),RRPCA(i,4)))
end
display(sprintf('\n'))
