clc;
close all;
clear all;

VeriTabaniYolu = uigetdir('C:\Users\skygt\Desktop\HOG', 'Egitilecek Veri Taban� Se�' );
TestVeriYolu=uigetdir('C:\Users\skygt\Desktop\HOG', 'Egitilecek Veri Taban� Se�' );
feature = hog(VeriTabaniYolu);
testresmi=Test(TestVeriYolu);