clc;
close all;
clear all;

VeriTabaniYolu = uigetdir('C:\Users\skygt\Desktop\HOG', 'Egitilecek Veri Tabaný Seç' );
TestVeriYolu=uigetdir('C:\Users\skygt\Desktop\HOG', 'Egitilecek Veri Tabaný Seç' );
feature = hog(VeriTabaniYolu);
testresmi=Test(TestVeriYolu);