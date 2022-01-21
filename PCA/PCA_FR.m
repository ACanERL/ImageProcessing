clear all
clc
cd 'C:\Users\skygt\Desktop\PCA'
load rndMtrx       % for randmoly choosing training images for each person.
NP = 10;           % number of people in database
TI = 10;           % number of images per person
% NTr = 5  ;         % number of train images per person                       
% RRPCA = [];        % recognition rate for PCA
% NTs = TI - NTr;    % number of test images  per person
NTr = 10;    % change number of training images 'NTr' per person
T=targetFunction(NTr,NP);
for itr=1:size(rndMtrx,1)  % run the program randomly 10 times then average results.
    % display(sprintf('%d Train Images ... Run No.: %d',(NTr),(itr))) 
    % Read train face images
    c=1;
    for i=1:NP
        for j=1:NTr
            im = ['ORL/face' int2str(rndMtrx(itr,(i-1)*TI+j)) '.bmp'];
            [X,MAP]=imread(im);
             x=ind2gray(X,MAP);
             [featureVector,hogVisualization]=extractHOGFeatures(x);
              A_trn(:,c) = featureVector;%double(x(:))/norm(double(x),2);   % norm(x,2) for normalization.      
%            A_trn(:,c) = double(x(:))/norm(double(x),2);
            c=c+1;
        end
    end
    clear memory
 % Read test face images
% c=1;
%     for i=1:NP
%         for j=NTr+1:TI
%             im = ['ORL/face' int2str(rndMtrx(itr,(i-1)*TI+j)) '.bmp'];
%             [X,MAP]=imread(im);
%              x=ind2gray(X,MAP);
%             [featureVector,hogVisualization]=extractHOGFeatures(x);
%             A_tst(:,c) = featureVector;%double(x(:))/norm(double(x),2);  % norm(x,2) for normalization.
%             c=c+1;        
%        end
%     end
end
neural=NeuralNet(A_trn,T);

  %% PCA Transform
% ====================
% Av=sum(A_trn')'/(NP*TI);           
% Avmtx=(ones(NP*NTr,1)*Av')';
% clear memory
% A=double(A_trn)-Avmtx;
% clear Avmtx Train
% [V,L]=eig (A'*A);
% Lamda = diag(L);
% clear L
% [r c]=size(V);
% Ld=(ones(r,1)*Lamda');
% clear lamda
% V=V./sqrt(Ld);  % whittening
% U= A*V;
% clear V Ld 
% A_trn=U'*double(A);  % feature vectors for train set
% clear A 
% Avmtx=(ones(NP*(TI-NTr),1)*Av')';
% clear Av
% B=double(Test)-Avmtx;
% clear Test Avmtx
% A_tst=U'*double(B);  % feature vectors for test set
% clear B U
%   neural=NeuralNet(A_trn,T);  
%% NEAREST NEIGHBOR  
% for i=1:NP*(TI-NTr)
%     At=A_tst(:,i);
%     A_temp=(ones(NP*NTr,1)*At')';
%     Diff=A_temp-A_trn;
%     % Euclidean Distance
%     [r,c]=min(diag(sqrt(Diff'*Diff)));
%     % Cosince Distance
%     [r1 c1]=min(1-(sum(A_temp.*A_trn)./(sqrt(sum(A_temp.*A_temp).*sum(A_trn.*A_trn)))));
%     % Manhatan Distance
%     [r2 c2]=min(sum(abs(Diff)));
%     mn(i)=ceil(c/NTr);      % min Distance location using Euclidean
%     mn1(i)=ceil(c1/NTr);    % min Distance location using Cosince
%     mn2(i)=ceil(c2/NTr);    % min Distance location using Manhatan
% end
% % Ground Truth
% testClass = ones(TI-NTr,1)*[1:NP];
% testClass=reshape(testClass,(TI-NTr)*NP,1);
% 
% % Manhatan Distance
% answer=mn2';
% correct = find( (testClass - answer == 0));
% Mn_L1_PCA(itr)= 100*size(correct,1) / size(answer,1);
% 
% % Euclidean Distance
% answer=mn';
% correct = find( (testClass - answer == 0));
% Euc_L2_PCA(itr)= 100*size(correct,1) / size(answer,1);
% 
% % Cosince Distance
% answer=mn1';
% correct = find( (testClass - answer == 0));
% Cos_PCA(itr)= 100*size(correct,1) / size(answer,1);
% 
% clear mn mn1 mn2 
% end

% RRPCA =[RRPCA; NTr mean([Mn_L1_PCA' Euc_L2_PCA' Cos_PCA' ])];s
% %% Complete results shown as a table
% display(sprintf('\n\n%-15s %-12s %-12s %-12s\n','#Train Images' , 'Manhattan' ,'Euclidean ', 'Cosine'))

% for i = 1 : NTr
%    display(sprintf('%-15d %-12f %-12f %-12f',RRPCA(i,1),RRPCA(i,2),RRPCA(i,3),RRPCA(i,4)))
% end
display(sprintf('\n'))



