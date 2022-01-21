function feature = hog(VeriTabaniYolu)
%Veri Taban�ndan verilerin �ekilmesis
EgitimVeri = dir(VeriTabaniYolu);
Egitim_Sayisi = 0;

for i = 1:size(EgitimVeri,1)
    if not(strcmp(EgitimVeri(i).name,'.')|strcmp(EgitimVeri(i).name,'..')|strcmp(EgitimVeri(i).name,'Thumbs.db')) %strcmp stringleri karsilastiriyor
        Egitim_Sayisi = Egitim_Sayisi + 1; % E�itim veritaban�ndaki t�m g�r�nt�lerin say�s�
    end
end

for i = 1 : Egitim_Sayisi 
    %int2str bir sayi �eklinde verinin string verisine at�lmas� i�in d�n��t�rmek gereklidir
    %Veritabanlar�ndaki her g�r�nt�n�n ad�n� kar��l�k gelen bir say� i
    %1.pgm,2.pgm gibi
    str = int2str(i);   
    str = strcat('\',str,'.pgm');
    str = strcat(VeriTabaniYolu,str);
    img = imread(str);
    [featureVector,hogVisualization]=extractHOGFeatures(img);
    feature(:,i)=featureVector;
    figure;
    imshow(img);
    hold on;
    plot(hogVisualization);
end

