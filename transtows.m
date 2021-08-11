function distance_matrix=transtows(a)
    matrix=full(a);
    N=size(matrix,1);
    distance_matrix=zeros(N,N);
    for i=1:N-1
        for j=i+1:N
            temp=matrix(i,:)+matrix(j,:);
            num_common_skill=sum(temp==2);
            if num_common_skill==0
                distance_matrix(i,j)=0;
            else
                distance_matrix(i,j)=1/num_common_skill;
            end
        end
    end
    distance_matrix=distance_matrix+distance_matrix';
end