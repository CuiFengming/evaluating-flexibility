function A_SF=sffunc(structure)
nd=size(structure,2);
ns=size(structure,1);
matfu_1=bipartite2full(structure);
graph1=graph(matfu_1);
sf=zeros(nd,nd);
for i=1:nd-1
    for j=i+1:nd
        sf(i,j)=maxflow(graph1,i+ns,j+ns);
    end
end
sf=sf+sf';
for i=1:nd
    sf(i,i)=sum(structure(:,i));
end
A_SF=max(eig(sf));


end