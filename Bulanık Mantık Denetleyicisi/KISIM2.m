A=[-3 -3;1 -9];
B=[1 0 ; 0 1];
C=[1 0];
U0=[100 0];
dt=0.01;
t0=0;
x0=[0 0];
k=1;
sizeA=size(A);
tend=5;
while(t0<tend)
    [x] = myrunge(A,B,U0,x0,dt);
    y(k) = 0;
    for i=1:sizeA(1)
        y(k) = y(k) + C(i) * x(i);
    end
    x0=x;
    t(k)= t0;
    t0 = t0 + dt;
    k = k + 1;
end
plot(t,y);
xlabel('t');
ylabel('y');
title('y-t grafigi');
grid