function structure=ernet(deg1,deg2)
E=sum(deg1);%随机连边，度分布不均匀
n=length(deg2);
which=randperm(n*n,E);
structure=zeros(n,n);
structure(which)=1;

end