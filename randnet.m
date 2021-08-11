function structure=randnet(deg1,deg2)
n=length(deg1);%Ëæ»úÅäÖÃ
edge1=[];
edge2=[];
for i=1:n
    temp1=i*ones(deg1(i),1);
    edge1=[edge1;temp1];
    
    temp2=i*ones(deg2(i),1);
    edge2=[edge2;temp2];
end
num_edge=length(edge1);
edge1=edge1(randperm(num_edge));
structure=sparse(edge1,edge2,ones(num_edge,1));
end