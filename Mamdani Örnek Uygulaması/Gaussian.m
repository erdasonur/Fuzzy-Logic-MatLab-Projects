function Gaussian(xT,w,x)
x=0:0.01:40;
a=(x-xT)/w; 
GAUSS=exp(-(1/2)*(a.^2));
plot(x,GAUSS); 
xlabel('x kesin sayisi'); 
ylabel('Uyelik Derecesi');
grid
end