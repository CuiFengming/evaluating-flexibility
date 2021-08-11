function structure=rewritingnet(deg1,deg2,p)
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

n_edge=length(edge);
n_relink=0;
while n_relink<n_edge*p
    which_pair=randperm(n_edge,2);
    x2=ceil(edge(which_pair(1))/n);
    x1=mod(edge(which_pair(1)),n)+n*(mod(edge(which_pair(1)),n)==0);
    x4=ceil(edge(which_pair(2))/n);
    x3=mod(edge(which_pair(2)),n)+n*(mod(edge(which_pair(2)),n)==0);
    if a(x1,x4)==0 && a(x3,x2)==0
        a(x1,x4)=1;
        a(x3,x2)=1;
        a(x1,x2)=0;
        a(x3,x4)=0;
        n_relink=n_relink+1;
    end
    edge=find(a);
end
structure=a;


end