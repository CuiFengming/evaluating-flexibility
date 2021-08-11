function distance_matrix=transtows_resource_sr(a)
    matrix=full(a);
    %下面这个决定了从哪层映射，有待商榷
    %此时决定向第左层supply投影
    N=size(matrix,1);
    w=zeros(N,N);
    M=size(matrix,2);
    for i=1:N
        for j=1:N
            kxj=sum(matrix(j,:));
            temp=zeros(M,1);
            for l=1:M
                temp(l)=matrix(i,l)*matrix(j,l)/sum(matrix(:,l));
            end
            w(i,j)=1/kxj*sum(temp);
        end
    end
    %目前先去倒数recipe，具体有待商榷
    distance_matrix=1./w;
end