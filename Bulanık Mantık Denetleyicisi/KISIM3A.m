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
r0=25;

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
%Z:ZERO P:POZITIF

NeD = EMIN;       NeO = EMIN;       NeY = 0;
ZeD = EMIN;       ZeO = 0;          ZeY = EMAX;
PeD = 0;          PeO = EMAX;       PeY = EMAX;

NdeD = DEMIN;     NdeO = DEMIN;     NdeY = 0;
ZdeD = DEMIN;     ZdeO = 0;         ZdeY = DEMAX;
PdeD = 0;         PdeO = DEMAX;     PdeY = DEMAX;

NduD = DUMIN;     NduO = DUMIN;     NduY = 0;
ZduD = DUMIN;     ZduO = 0;         ZduY = DUMAX;
PduD = 0;         PduO = DUMAX;     PduY = DUMAX;

ee = EMAX;
dee = 0;
E = EMAX;
de = 0;
e0 = EMAX;
Z(1) = 0;
Z0 = 0;

DU=[ZduO  PduO  PduO
    NduO  ZduO  PduO
    NduO  NduO  ZduO
   ];

SizeDU=size(DU);

while(t0<tend)

    E=limiter(EMIN,EMAX,ee);
    MUeN = Triangle_value(NeD, NeO, NeY, E);
    MUeZ = Triangle_value(ZeD, ZeO, ZeY, E);
    MUeP = Triangle_value(PeD, PeO, PeY, E);
    
    DE=limiter(DEMIN,DEMAX,dee);
    MUDeN = Triangle_value(NdeD, NdeO, NdeY, DE);
    MUDeZ = Triangle_value(ZdeD, ZdeO, ZdeY, DE);
    MUDeP = Triangle_value(PdeD, PdeO, PdeY, DE);
    
    MU=[
        min(MUeP,MUDeN)     min(MUeP,MUDeZ)     min(MUeP,MUDeP)
        min(MUeZ,MUDeN)     min(MUeZ,MUDeZ)     min(MUeZ,MUDeP)
        min(MUeN,MUDeN)     min(MUeN,MUDeZ)     min(MUeN,MUDeP)
        ];
    
    MUDU=[MU(1,1)*DU(1,1)   MU(1,2)*DU(1,2)     MU(1,3)*DU(1,3)
          MU(2,1)*DU(2,1)   MU(2,2)*DU(2,2)     MU(2,3)*DU(2,3)
          MU(3,1)*DU(3,1)   MU(3,2)*DU(3,2)     MU(3,3)*DU(3,3)
        ];
    
    sizeMU=size(MU);
    z=sum(MUDU)/sum(MU);
    Z=limiter(DUMIN, DUMAX, z);
    Z(k) = Z0  +Z;
    Z(k)=limiter(0, DUMAX, Z(k));
    Z0 = Z(k);
    U00 = Z(k) * U0;
    
    [x]=myrunge(A,B,U00,x0,dt); 
    UU(k)=U00(1); 
    t(k)=t0+dt;         
    t0=t(k); r(k)=r0;            
    y(k)=x0(1); e(k)=r(k)-y(k);     
    de(k)=e(k)-e0; ee=e(k);  dee=de(k);   e0=e(k);   
    for n=1:sizeA(1) 
        x0(n)=x(n);  
        XX(k,n)=x(n); 
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
