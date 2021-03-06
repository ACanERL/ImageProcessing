function neural=NeuralNet(A_trn,T)

% Solve a Pattern Recognition Problem with a Neural Network
% Script generated by Neural Pattern Recognition app
% Created Sat Dec 21 16:04:26 EET 2019
%
% This script assumes these variables are defined:
%
%   A_trn - input data.
%   T - target data.

x = A_trn;
t = T;

% Create a Pattern Recognition Network
hiddenLayerSize = 15; %neron say?s?
net = patternnet(hiddenLayerSize);


% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100; %y?z delik e?itim dilimi
net.divideParam.valRatio =0/100;%dogrulama y?zdelik
net.divideParam.testRatio = 30/100;%test y?zdelik k?s?m


% Train the Network
[net,tr] = train(net,x,t); %verilen degerlerin egitilmesi

% Test the Network 
y = net(x);
e = gsubtract(t,y);
tind = vec2ind(t);
yind = vec2ind(y);
percentErrors = sum(tind ~= yind)/numel(tind);
performance = perform(net,t,y)

% View the Network
view(net)
neural=net;

% Plots
% Uncomment these lines to enable various plots.
figure, plotperform(tr)
figure, plottrainstate(tr)
figure, plotconfusion(t,y)
figure, plotroc(t,y)
figure, ploterrhist(e)
end
