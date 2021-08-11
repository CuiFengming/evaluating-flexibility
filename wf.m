function w=wf(A)
F=A;
F(F>0)=1;
m = sum(sum(F));
n = size(F,1);
W = zeros(n, m);
k = 1;
for i = 1 : n
    for j = i : n
        if F(i,j) ~= 0;
            W(i,k) = 1*A(i,j);
            W(j,k) = -1*A(i,j);
            k = k + 1;
        end
    end
end



end