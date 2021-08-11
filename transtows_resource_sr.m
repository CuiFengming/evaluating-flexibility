function distance_matrix=transtows_resource_sr(a)
    matrix=full(a);
    %������������˴��Ĳ�ӳ�䣬�д���ȶ
    %��ʱ����������supplyͶӰ
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
    %Ŀǰ��ȥ����recipe�������д���ȶ
    distance_matrix=1./w;
end