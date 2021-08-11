function R1=Rf(A,t)
M=mf(A,2)*mf(A,1);
R1=M^t*A';
R1=R1';
R1=full(R1);
end