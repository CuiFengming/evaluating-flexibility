function structure=wsnet(deg1,deg2,p)
n=length(deg1);
k=mean(deg2);
structure=zeros(n,n);
temp=[structure,structure];
for i=1:n
    temp(i,i:(i+k-1))=1;
end
structure=temp(:,1:n)+temp(:,n+1:end);
a=structure;
edge=find(a);
isrelink=binornd(1,p,sum(deg1),1);

for i=1:sum(deg1)
    if isrelink(i)==1
        x2=ceil(edge(i)/n);
        x1=mod(edge(i),n)+n*(mod(edge(i),n)==0);
        temp=a(x1,:);
        which=find(temp==0);
        x3=randi(length(which));
        a(x1,x2)=0;
        a(x1,which(x3))=1;
    end
end

structure=a;


end