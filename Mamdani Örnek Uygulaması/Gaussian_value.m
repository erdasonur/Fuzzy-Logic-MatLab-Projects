function y=Gaussian_value(xT,w,x)
a=(x-xT)/w; 
y=exp(-(1/2)*(a.^2));
end