function [expansion,eig_arra_min]=expfunc(structure)

matfu_1=bipartite2full(structure);
incidence=mattransf(matfu_1,0);
L=incidence*incidence';
[eig_arra,eig_full]=eig(L);
eig_full=diag(eig_full);
eig_sorted=sort(eig_full);
expansion=eig_sorted(2);

index=find(eig_full==expansion);
eig_arra_min=eig_arra(:,index);

end