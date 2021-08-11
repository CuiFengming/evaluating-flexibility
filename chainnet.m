function structure=chainnet(deg1,deg2)
n=length(deg1);
k=mean(deg2);
edge1=[];
edge2=[];
structure=zeros(n,n);
temp=[structure,structure];
for i=1:n
    temp(i,i:(i+k-1))=1;
end
structure=temp(:,1:n)+temp(:,n+1:end);

end