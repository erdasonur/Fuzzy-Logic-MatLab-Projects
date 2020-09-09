function [x] = myrunge(A,B,U,x0,dt)

sizeA=size(A);
i=1; j=1;
while(i<=sizeA(1))
    a(i)=0;
    while(j<=sizeA(2))
        x1(j)=x0(j);
        a(i) = a(i) + A(i,j)*x1(j) + B(i,j)*U(j);
        j = j + 1;
    end
    a(i) = a(i) * dt;
    j = 1;
    i = i + 1;
end
i=1; j=1;
while(i<=sizeA(1))
    b(i)=0;
    while(j<=sizeA(2))
        x2(j)=x0(j)+a(j)/2;
        b(i)= b(i) + A(i,j)*x2(j) + B(i,j)*U(j);
        j = j + 1;
    end
    b(i) = b(i) * dt;
    j = 1;
    i = i + 1;
end
i=1; j=1;
while(i<=sizeA(1))
    c(i)=0;
    while(j<=sizeA(2))
        x3(j)=x0(j)+b(j)/2;
        c(i) = c(i) + A(i,j)*x3(j) + B(i,j)*U(j);
        j = j + 1;
    end
    c(i) = c(i) * dt;
    j = 1;
    i = i + 1;
end
i=1; j=1;
while(i<=sizeA(1))
    d(i) = 0;
    while(j<=sizeA(2))
        x4(j)=x0(j)+c(j);
        d(i) = d(i) + A(i,j)*x4(j) + B(i,j)*U(j);
        j = j + 1;
    end
    d(i) = d(i) * dt;
    j = 1;
    i = i + 1;
end
for i=1:sizeA(1)
    x(i) = x0(i) + (a(i) + 2 * b(i) + 2 * c(i) + d(i)) / 6;
end
end