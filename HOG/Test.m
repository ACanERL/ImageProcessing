function testresmi = Test(TestVeriYolu)

TestVeri = dir(TestVeriYolu);
Egitim_Sayisi = 0;

for i = 1:size(TestVeri,1)
    if not(strcmp(TestVeri(i).name,'.')|strcmp(TestVeri(i).name,'..')|strcmp(TestVeri(i).name,'Thumbs.db')) %strcmp stringleri karsilastiriyor
        Egitim_Sayisi = Egitim_Sayisi + 1; % Eðitim veritabanýndaki tüm görüntülerin sayýsý
    end
end

for i = 1 : Egitim_Sayisi 
    %int2str bir sayi þeklinde verinin string verisine atýlmasý için dönüþtürmek gereklidir
    %Veritabanlarýndaki her görüntünün adýný karþýlýk gelen bir sayý i
    %1.pgm,2.pgm gibi
    str = int2str(i);   
    str = strcat('\',str,'.pgm');
    str = strcat(TestVeriYolu,str);
    img = imread(str);
    [featureVector,hogVisualization]=extractHOGFeatures(img);
    testresmi=featureVector;
    figure;
    imshow(img);
    title('Test Resmi')
    hold on;
    plot(hogVisualization);
  
end



