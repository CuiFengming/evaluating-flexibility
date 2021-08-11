function trucnorm=tracnorm(n,u,delta,lower,upper)

temp=normrnd(u,delta,[1,100*n]);
temp1=temp(temp>=lower);
temp2=temp1(temp1<=upper);
trucnorm=temp2(1:n);
end