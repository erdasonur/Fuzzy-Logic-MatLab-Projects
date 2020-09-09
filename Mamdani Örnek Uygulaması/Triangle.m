function Triangle(x1,xT,x2,x)
x=x1:0.01:x2;
a=(x-x1)/(xT-x1);
b=(x2-x)/(x2-xT);
c=0;
mu=max(min(a,b),c);
plot(x,mu);
xlabel('x kesin sayisi');
ylabel('Uyelik derecesi');
grid
end