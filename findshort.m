function shortage=findshort(structure,D,C)

structure=full(structure);
ns=size(structure,1);
nd=size(structure,2);
matrix_full=[[C;zeros(ns,ns)],[zeros(1,nd);structure];[0*structure';zeros(1,ns)],zeros(nd+1,nd)];
matrix_add2point=[zeros(ns+nd+2,1),matrix_full,[zeros(ns+1,1);D';0]];
maxf=maxflow(digraph(matrix_add2point),1,ns+nd+2);
shortage=sum(D)-maxf;
end