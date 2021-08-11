function H=hf(structure,g)
%带效率因子的R矩阵计算函数

s=structure;
n_s=size(structure,1);
n_d=size(structure,2);
deg_s=sum(structure,2);
deg_d=sum(structure,1);
H=zeros(n_s,n_d);
for i=1:n_s
    for j=1:n_d
        for k=1:n_d
            for l=1:n_s
                H(i,j)=H(i,j)+s(i,k)*g(i,k)*s(l,j)*g(l,j)*s(l,k)/(deg_d(k)*deg_s(l));
            end
        end
    end
end

end