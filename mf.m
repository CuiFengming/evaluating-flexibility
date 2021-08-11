function M=mf(A,op)
if op==1
    M=A*inv(diag(sum(A))); %U
else
    M=A'*inv(diag(sum(A,2))); %V
end

end