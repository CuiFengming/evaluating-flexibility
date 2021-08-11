clc;
load samedegree1;
A=chain3;
nd=length(A);
ns=nd;
M=mf(A,2)*mf(A,1);
eig2=sort(eig(M),'descend');
eig2=eig2(2);

matfu_1=bipartite2full(A);
incidence=mattransf(matfu_1,0);
L=incidence*incidence';
eig_sorted=sort(eig(L));
A_connect=eig_sorted(2);

expected_value=((3-A_connect)/3)^2;



APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径
WS_APL=APL1(transtows(A));

graph1=graph(matfu_1);
    sf=zeros(nd,nd);
    for i=1:nd-1
        for j=i+1:nd
            sf(i,j)=maxflow(graph1,i+ns,j+ns);
        end
    end
    sf=sf+sf';
    for i=1:nd
        sf(i,i)=sum(A(:,i));
    end
    SF=max(eig(sf));

    APL7=@(WS,structure)norm(1-WS^1*structure,2);
FG1=APL7(transtows_resource_so(A),A);
    
    aaa=[FG1;WS_APL;SF;A_connect];