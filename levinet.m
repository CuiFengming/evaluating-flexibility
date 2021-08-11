function structure=levinet(deg1,deg2)
%可能目前是错的
n=length(deg1);
structure=zeros(n,n);
for i=1:n
    for k=1:deg2(i)
        sum(structure,1)=sum1;
        sum(structure,2)=sum2;
        which1=find(sum1<2);
        which2=find(sum2<2); 
    end
end

end