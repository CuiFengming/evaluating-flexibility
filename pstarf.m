function [pstar,M]=pstarf(structure)
degr=sum(structure,1);
degl=sum(structure,2);
n=length(degr);
ml=repmat(1./degr,n,1).*structure;
mr=repmat(1./degl',n,1).*structure';
M=ml*mr;
Ms=M-diag(ones(1,n));
Mb=[Ms;ones(1,n)];
b=[zeros(n,n);degr];
pstar=Mb\b;
end