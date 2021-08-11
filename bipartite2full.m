function matrix_full=bipartite2full(structure)
structure=full(structure);
ns=size(structure,1);
nd=size(structure,2);
matrix_full=[zeros(ns,ns),structure;structure',zeros(nd,nd)];
end
