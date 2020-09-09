%Hesaplanacak devam durumu icin ogrenci sayisi,guncel uygulanabilirlik sayisi
%ve teorik altyapisi katkisi sayisi
x=50;
y=0.6;
z=0.3;


%Ogrenci sayilarinin tanimlamasi
DXD=0;    DXO=0;    DXY=50;
OXD=0;    OXO=50;   OXY=100;
YXD=50;   YXO=100;  YXY=100;

%Guncel Uygulanabilirlik sayilarinin tanimlanmasi
DYD=0;    DYO=0;    DYY=0.5; 
OYD=0;    OYO=0.5;  OYY=1; 
YYD=0.5;  YYO=1;    YYY=1;

%Teorik altyapisi katkisi sayilarinin tanimlanmasi
DZD=0;    DZO=0;    DZY=0.5;
OZD=0;    OZO=0.5;  OZY=1;
YZD=0.5;  YZO=1;    YZY=1;

%Devam ettirilmesi durumu sayilarinin tanimlanmasi
HWD=0;    HWO=0;    HWY=0.5;
KWD=0;    KWO=0.5;  KWY=1;
EWD=0.5;  EWO=1;    EWY=1;

subplot(221)
%Ogrenci sayisi bulanik uyelik fonksiyonunun cizdirilmesi
Triangle(DXD,DXO,DXY,x);
hold on
Triangle(OXD,OXO,OXY,x);
Triangle(YXD,YXO,YXY,x);
title('Ogrenci Sayisi');
subplot(222)
%Guncel Uygulanabilirlik sayilarinin bulanik uyelik fonksiyonun cizdirilmesi
Triangle(DYD,DYO,DYY,x);
hold on
Triangle(OYD,OYO,OYY,x);
Triangle(YYD,YYO,YYY,x);
title('Guncel Uygulanabilirlik Yuzde Degeri');
subplot(223)
%Teorik Altyapisi Katkisi sayilarinin bulanik uyelik fonksiyonun cizdirilmesi
Triangle(DZD,DZO,DZY,x);
hold on
Triangle(OZD,OZO,OZY,x);
Triangle(YZD,YZO,YZY,x);
title('Teorik Altyapisi Katkisi Yuzde Degeri');
subplot(224)
%Devam ettirilmesi durumu sayilarinin bulanik uyelik fonksiyonun cizdirilmesi
Triangle(HWD,HWO,HWY,x);
hold on
Triangle(KWD,KWO,KWY,x);
Triangle(EWD,EWO,EWY,x);
title('Cikis Devam Ettirilme Durumu');
%Kural tablosunun olusturulmasi
K=[HWO   HWO   KWO
   HWO   KWO   KWO
   KWO   KWO   EWO
   HWO   KWO   KWO
   KWO   KWO   EWO
   KWO   EWO   EWO
   KWO   KWO   EWO
   KWO   EWO   EWO
   EWO   EWO   EWO];

%Bulaniklastirma Islemleri
%Bulanik uyelik fonksiyonunda x kesin sayisi icin uyelik degeri
%alinmaktadir
MUDX=Triangle_value(DXD,DXO,DXY,x);
MUOX=Triangle_value(OXD,OXO,OXY,x);
MUYX=Triangle_value(YXD,YXO,YXY,x);

MUDY=Triangle_value(DYD,DYO,DYY,y);
MUOY=Triangle_value(OYD,OYO,OYY,y);
MUYY=Triangle_value(YYD,YYO,YYY,y);

MUDZ=Triangle_value(DZD,DZO,DZY,z);
MUOZ=Triangle_value(OZD,OZO,OZY,z);
MUYZ=Triangle_value(YZD,YZO,YZY,z);

%Kural Isleme
%Uyelik dereceleri aras?nda minimum alma islemi ile 27 tane kural
%islenmistir MU minimum uyelik derecesini temsil etmektedir
MU=[min(min(MUDX,MUDY),MUDZ)   min(min(MUDX,MUDY),MUOZ)   min(min(MUDX,MUDY),MUYZ)
    min(min(MUDX,MUOY),MUDZ)   min(min(MUDX,MUOY),MUOZ)   min(min(MUDX,MUOY),MUYZ)
    min(min(MUDX,MUYY),MUDZ)   min(min(MUDX,MUYY),MUOZ)   min(min(MUDX,MUYY),MUYZ)
    min(min(MUOX,MUDY),MUDZ)   min(min(MUOX,MUDY),MUOZ)   min(min(MUOX,MUDY),MUYZ)
    min(min(MUOX,MUOY),MUDZ)   min(min(MUOX,MUOY),MUOZ)   min(min(MUOX,MUOY),MUYZ)
    min(min(MUOX,MUYY),MUDZ)   min(min(MUOX,MUYY),MUOZ)   min(min(MUOX,MUYY),MUYZ)
    min(min(MUYX,MUDY),MUDZ)   min(min(MUYX,MUDY),MUOZ)   min(min(MUYX,MUDY),MUYZ)
    min(min(MUYX,MUOY),MUDZ)   min(min(MUYX,MUOY),MUOZ)   min(min(MUYX,MUOY),MUYZ)
    min(min(MUYX,MUYY),MUDZ)   min(min(MUYX,MUYY),MUOZ)   min(min(MUYX,MUYY),MUYZ)];
%MUK minimum üyelik derecesi matrisi ile K matrisinin carpimini temsil
%etmektedir
MUK=[MU(1,1)*K(1,1)  MU(1,2)*K(1,2)  MU(1,3)*K(1,3)
     MU(2,1)*K(2,1)  MU(2,2)*K(2,2)  MU(2,3)*K(2,3)
     MU(3,1)*K(3,1)  MU(3,2)*K(3,2)  MU(3,3)*K(3,3)
     MU(4,1)*K(4,1)  MU(4,2)*K(4,2)  MU(4,3)*K(4,3)
     MU(5,1)*K(5,1)  MU(5,2)*K(5,2)  MU(5,3)*K(5,3)
     MU(6,1)*K(6,1)  MU(6,2)*K(6,2)  MU(6,3)*K(6,3)
     MU(7,1)*K(7,1)  MU(7,2)*K(7,2)  MU(7,3)*K(7,3)
     MU(8,1)*K(8,1)  MU(8,2)*K(8,2)  MU(8,3)*K(8,3)
     MU(9,1)*K(9,1)  MU(9,2)*K(9,2)  MU(9,3)*K(9,3)];

sizeMU=size(MU);
Toplam1=0;Toplam2=0;
i=1; j=1;
while(i<=sizeMU(1))
    while(j<=sizeMU(2))
        Toplam1=Toplam1+MUK(i,j);
        Toplam2=Toplam2+MU(i,j);
        j=j+1;
    end
    j=1;
    i=i+1;
end
f=Toplam1/Toplam2;
fprintf('w kesin cikis degeri = %f ',f);
