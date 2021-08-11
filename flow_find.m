function num_path_weighted=flow_find(gf,ns,nd,i,j)
M=1000;
spr=gf.adjacency;
matrix_flow=full(spr);
num_path_weighted=zeros(ns+nd-1,1);
[sp,tp]=find(matrix_flow);
num_path=length(find(tp==j));
path=cell(3,1);
for pp=1:num_path
    temp=shortestpath(gf,i,j);
    n_cut=length(temp);
    num_path_weighted(n_cut-1)=num_path_weighted(n_cut-1)+(ns+1-(n_cut-1)/2)/ns;
        path{pp}=temp;
    for ppp=1:n_cut-1
        spr(temp(ppp),temp(ppp+1))=M;
    end
    gf=digraph(spr);
end
end