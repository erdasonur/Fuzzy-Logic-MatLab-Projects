clc;clear;
A=[-3 -3 ; 1 -9];
B=[1 0 ; 0 1];
u=[100 ; 0];
dt=0.01;
t0=0;
tend=2;
k=1;
U0=[u(1) ; u(2)];
sizeA=size(A);
r0=20;

for i=1:sizeA(1)
    x0(i)=0;
end

EMAX = r0;
EMIN = -EMAX;
DEMAX = EMAX/10;
DEMIN = -DEMAX;
DUMAX = 1;
DUMIN = -1;


%N:NEGATIF D:DUSUK O:ORTA Y:YUKSEK
%S:SIFIR P:POZITIF



 
NBeD = EMIN;        NBeO = EMIN;        NBeY = EMIN/2;
NSeD = EMIN;        NSeO = EMIN/2;      NSeY = 0;
ZEeD = EMIN/2;      ZEeO = 0;           ZEeY = EMAX/2;
PSeD = 0;           PSeO = EMAX/2;      PSeY = EMAX;
PBeD = EMAX/2;      PBeO = EMAX;        PBeY = EMAX;

NBdeD = DEMIN;      NBdeO = DEMIN;       NBdeY = DEMIN/2;
NSdeD = DEMIN;      NSdeO = DEMIN/2;     NSdeY = 0;
ZEdeD = DEMIN/2;    ZEdeO = 0;           ZEdeY = DEMAX/2;
PSdeD = 0;          PSdeO = DEMAX/2;     PSdeY = DEMAX;
PBdeD = DEMAX/2;    PBdeO = DEMAX;       PBdeY = DEMAX;

NBduD = DUMIN;      NBduO = DUMIN;       NBduY = DUMIN/2;
NSduD = DUMIN;      NSduO = DUMIN/2;     NSduY = 0;
ZEduD = DUMIN/2;    ZEduO = 0;           ZEduY = DUMAX/2;
PSduD = 0;          PSduO = DUMAX/2;     PSduY = DUMAX;
PBduD = DUMAX/2;    PBduO = DUMAX;       PBduY = DUMAX;


ee = EMAX;
dee = 0;
E = EMAX;
de = 0;
e0 = EMAX;
DE = 0;

C(1) = 0;
    C0 = 0;

DU=[ZEduO  PSduO  PSduO  PBduO  PBduO
    NSduO  ZEduO  PSduO  PSduO  PBduO
    NSduO  NSduO  ZEduO  PSduO  PSduO
    NBduO  NSduO  NSduO  ZEduO  PSduO
    NBduO  NBduO  NSduO  NSduO  ZEduO
   ];

SizeDU=size(DU);

while(t0<tend)

    E=limiter(EMIN,EMAX,ee);
    MUeNB = Triangle_value(NBeD, NBeO, NBeY, E);
    MUeNS = Triangle_value(NSeD, NSeO, NSeY, E);
    MUeZE = Triangle_value(ZEeD, ZEeO, ZEeY, E);
    MUePS = Triangle_value(PSeD, PSeO, PSeY, E);
    MUePB = Triangle_value(PBeD, PBeO, PBeY, E);
    
    DE=limiter(DEMIN,DEMAX,dee);
    MUDeNB = Triangle_value(NBdeD, NBdeO, NBdeY, DE);
    MUDeNS = Triangle_value(NSdeD, NSdeO, NSdeY, DE);
    MUDeZE = Triangle_value(ZEdeD, ZEdeO, ZEdeY, DE);
    MUDePS = Triangle_value(PSdeD, PSdeO, PSdeY, DE);
    MUDePB = Triangle_value(PBdeD, PBdeO, PBdeY, DE);
    
    MU=[
        min(MUePB,MUDeNB)   min(MUePB,MUDeNS)   min(MUePB,MUDeZE)   min(MUePB,MUDePS)   min(MUePB,MUDePB)
        min(MUePS,MUDeNB)   min(MUePS,MUDeNS)   min(MUePS,MUDeZE)   min(MUePS,MUDePS)   min(MUePS,MUDePB)
        min(MUeZE,MUDeNB)   min(MUeZE,MUDeNS)   min(MUeZE,MUDeZE)   min(MUeZE,MUDePS)   min(MUeZE,MUDePB)
        min(MUeNS,MUDeNB)   min(MUeNS,MUDeNS)   min(MUeNS,MUDeZE)   min(MUeNS,MUDePS)   min(MUeNS,MUDePB)
        min(MUeNB,MUDeNB)   min(MUeNB,MUDeNS)   min(MUeNB,MUDeZE)   min(MUeNB,MUDePS)   min(MUeNB,MUDePB)
        ];
    
    MUDU=[MU(1,1)*DU(1,1)   MU(1,2)*DU(1,2)     MU(1,3)*DU(1,3)     MU(1,4)*DU(1,4)     MU(1,5)*DU(1,5)
          MU(2,1)*DU(2,1)   MU(2,2)*DU(2,2)     MU(2,3)*DU(2,3)     MU(2,4)*DU(2,4)     MU(2,5)*DU(2,5)
          MU(3,1)*DU(3,1)   MU(3,2)*DU(3,2)     MU(3,3)*DU(3,3)     MU(3,4)*DU(3,4)     MU(3,5)*DU(3,5)
          MU(4,1)*DU(4,1)   MU(4,2)*DU(4,2)     MU(4,3)*DU(4,3)     MU(4,4)*DU(4,4)     MU(4,5)*DU(4,5)
          MU(5,1)*DU(5,1)   MU(5,2)*DU(5,2)     MU(5,3)*DU(5,3)     MU(5,4)*DU(5,4)     MU(5,5)*DU(5,5)
        ];
    
    sizeMU=size(MU);
    
    C1=sum(MUDU)/sum(MU);
    disp(C1)
    C=limiter(DUMIN, DUMAX, C1);
    C(k) = C0  +C;
    Ct=limiter(0, DUMAX, C(k));
    C0 = Ct;
    U00 = C(k) * U0;
    
    [x]=myrunge(A,B,U00,x0,dt);
    UU(k)=U00(1); 
    t(k)=t0+dt;         t0=t(k); r(k)=r0;            
    y(k)=x0(1);         e(k)=r(k)-y(k);     
    de(k)=e(k)-e0;      ee=e(k);  dee=de(k);    e0=e(k);   
    for i=1:sizeA(1) 
        x0(i)=x(i);  XX(k,i)=x(i); 
    end
    k=k+1;
end

subplot(211);
plot(t,y,t,r);
xlabel('Zaman(t)'); ylabel('Cikis(y) - Referans(r)');
title(' (Cikis - Referans) - Zaman Grafigi');
grid
subplot(212)
plot(t,e)
xlabel('Zaman(t)'); ylabel('Hata(e)');
title(' Hata - Zaman Grafigi');
grid