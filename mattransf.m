function W = mattransf(F, f)
if f == 0
    m = sum(sum(F));
    n = size(F,1);
    W = zeros(n, m);
    k = 1;
    for i = 1 : n
        for j = i : n
            if F(i,j) ~= 0;
                W(i,k) = 1;
                W(j,k) = -1;
                k = k + 1;
            end
        end
    end
end

if f == 1
    m = size(F,2);
    n = size(F,1);
    W = zeros(n,m);
    for i = 1 : m
        a = find(F(:,i) ~= 0);
        if find(a(1),i) == 1
            W(a(1),a(2)) = 1;
        else
            W(a(2),a(1)) = 1;
        end
    end
end
end