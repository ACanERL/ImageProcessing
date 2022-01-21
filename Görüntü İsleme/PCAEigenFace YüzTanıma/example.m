% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
               

clear all
clc
close all

% You can customize and fix initial directory paths
TrainDatabasePath = uigetdir('C:\Users\skygt\Desktop\Y�zTanima S�f�rdan', 'Select training database path' );
TestDatabasePath = uigetdir('C:\Users\skygt\Desktop\Y�zTanima S�f�rdan', 'Select test database path');

prompt = {'Enter test image name (a number between 1 to 10):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {'1'};

TestImage  = inputdlg(prompt,dlg_title,num_lines,def);%inputdlg ile karaktter  h�cre dizisi olu�turulur.
TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.pgm');% strcat bir stringi digerinin �tekinin arkasa�na ekler

im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

imshow(im)
title('Test Resmi');
figure,imshow(SelectedImage);
title('E�le�en Resim');

str = strcat('E�le�en :  ',OutputName);
disp(str)

