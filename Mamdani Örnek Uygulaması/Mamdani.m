function f=Mamdani(x,y)

LSL=0;   LST=0;   LSR=100;
MSL=0;   MST=100; MSR=200;
HSL=100; HST=200; HSR=200;

LTT=0; LTW=5.5;
WTT=20; WTW=5.5;
HTT=40; HTW=5.5;

LPL=0;    LPT=0;     LPR=0.5;
MPL=0;    MPT=0.5;   MPR=1;
HPL=0.5;  HPT=1;     HPR=1;

%Triangle(LSL,LST,LSR,x);
%hold on
%Triangle(MSL,MST,MSR,x);
%Triangle(HSL,HST,HSR,x);

%Gaussian(LTT,LTW,x);
%hold on
%Gaussian(WTT,WTW,x);
%Gaussian(HTT,HTW,x);

%Triangle(LPL,LPT,LPR,x);
%hold on
%Triangle(MPL,MPT,MPR,x);
%Triangle(HPL,HPT,HPR,x);

K=[LPT   LPT   LPT
   MPT   MPT   MPT
   HPT   HPT   HPT];


MULS=Triangle_value(LSL,LST,LSR,x);
MUMS=Triangle_value(MSL,MST,MSR,x);
MUHS=Triangle_value(HSL,HST,HSR,x);

MULT=Gaussian_value(LTT,LTW,y);
MUWT=Gaussian_value(WTT,WTW,y);
MUHT=Gaussian_value(HTT,HTW,y);

MU=[min(MULS,MULT)  min(MULS,MUWT)  min(MULS,MUHT)
    min(MUMS,MULT)   min(MUMS,MUWT)   min(MUMS,MUHT)
    min(MUHS,MULT)   min(MUHS,MUWT)   min(MUHS,MUHT)];

MUK=[MU(1,1)*K(1,1)  MU(1,2)*K(1,2)  MU(1,3)*K(1,3)
      MU(2,1)*K(2,1)  MU(2,2)*K(2,2)  MU(2,3)*K(2,3)
      MU(3,1)*K(3,1)  MU(3,2)*K(3,2)  MU(3,3)*K(3,3)];
  
Toplam1=0;Toplam2=0;
for n=1:3
    for m=1:3
        Toplam1=Toplam1+MUK(n,m);
        Toplam2=Toplam2+MU(n,m);
    end
end
f=Toplam1/Toplam2;
end
