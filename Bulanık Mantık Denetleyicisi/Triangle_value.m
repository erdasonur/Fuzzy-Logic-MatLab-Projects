function y=Triangle_value(x1,xT,x2,x)
y=0;
a=(x-x1)/(xT-x1);
b=(x2-x)/(x2-xT);
c=0;
y=max(min(a,b),c);
end