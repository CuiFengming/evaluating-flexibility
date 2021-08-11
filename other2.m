clc;
clear;

%case 2 ************************************************
D2=[1.5,1.5,1.5,0.5,0.5,0.5];
num_strut=3;

arc2_1=[[1,2,2,3,3,4,4,5,5,6,6]',[1,1,2,2,3,2,4,3,5,3,6]'];
structure2_1=sparse(arc2_1(:,1),arc2_1(:,2),ones(length(arc2_1),1));

arc2_2=[[1,1,2,2,3,3,4,4,5,5,6,6,]',[1,3,2,5,1,3,3,4,1,2,2,6]'];
structure2_2=sparse(arc2_2(:,1),arc2_2(:,2),ones(length(arc2_2),1));

arc2_3=[[1,1,2,2,3,3,4,4,5,5,6,6]',[1,3,2,3,1,4,3,5,1,2,2,6]'];
structure2_3=sparse(arc2_3(:,1),arc2_3(:,2),ones(length(arc2_3),1));

%*****************************************************

%% index1*****  WS_APL  ********************************************
APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%ƽ�����·��
APL_index1=zeros(1,num_strut);

WS1_1=transtows(structure2_1);
APL_index1(1)=APL1(WS1_1);

WS1_2=transtows(structure2_2);
APL_index1(2)=APL1(WS1_2);

WS1_3=transtows(structure2_3);
APL_index1(3)=APL1(WS1_3);

%% index2*****  WS_resource_do_APL  ********************************
APL2=@(WS)mean(mean(distances(digraph(WS))));
APL_index2=zeros(1,num_strut);

WS2_1=transtows_resource_do(structure2_1);
APL_index2(1)=APL2(WS2_1);

WS2_2=transtows_resource_do(structure2_2);
APL_index2(2)=APL2(WS2_2);

WS2_3=transtows_resource_do(structure2_3);
APL_index2(3)=APL2(WS2_3);

%% index3*****  WS_resource_so_APL  ********************************
APL3=@(WS)mean(mean(distances(digraph(WS))));
APL_index3=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure2_1);
APL_index3(1)=APL3(WS2_1);

WS2_2=transtows_resource_so(structure2_2);
APL_index3(2)=APL3(WS2_2);

WS2_3=transtows_resource_so(structure2_3);
APL_index3(3)=APL3(WS2_3);

%% index4*****  WS_resource_dr_APL  ********************************
APL4=@(WS)mean(mean(distances(digraph(WS))));
APL_index4=zeros(1,num_strut);

WS2_1=transtows_resource_dr(structure2_1);
APL_index4(1)=APL4(WS2_1);

WS2_2=transtows_resource_dr(structure2_2);
APL_index4(2)=APL4(WS2_2);

WS2_3=transtows_resource_dr(structure2_3);
APL_index4(3)=APL4(WS2_3);

%% index5*****  WS_resource_sr_APL  *******************************************
APL5=@(WS)mean(mean(distances(digraph(WS))));
APL_index5=zeros(1,num_strut);

WS2_1=transtows_resource_sr(structure2_1);
APL_index5(1)=APL5(WS2_1);

WS2_2=transtows_resource_sr(structure2_2);
APL_index5(2)=APL5(WS2_2);

WS2_3=transtows_resource_sr(structure2_3);
APL_index5(3)=APL5(WS2_3);

%% index6*****  WS_directed_APL  ********************************
APL6=@(WS)(sum(sum(triu(distances(digraph(WS)),1)))+sum(sum(tril(distances(digraph(WS)),-1))))/(length(WS)*(length(WS)-1));
APL_index6=zeros(1,num_strut);

WS1_1=transtows_degree(structure2_1);
APL_index6(1)=APL6(WS1_1);

WS1_2=transtows_degree(structure2_2);
APL_index6(2)=APL6(WS1_2);

WS1_3=transtows_degree(structure2_3);
APL_index6(3)=APL6(WS1_3);

%% index7*****  A_IFR  ********************************
% APL7=@(WS,structure)max(eig((1-WS^(length(D2)/2)*structure).^2));
% APL7=@(WS,structure)sum((sum((1-(WS^1)*structure).^2,1)).^0.5.*std(1-(WS^1)*structure,0,1)./sum(std(1-(WS^1)*structure,0,1)));
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./sum((WS*structure).^2,1).^0.5);
APL7=@(WS,structure)norm(1-WS^1*structure,2);
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./(sum((WS*structure).^2,1).^0.5.*sum(structure)));
A_IFR=zeros(1,num_strut);

WS1_1=transtows_resource_so(structure2_1);
A_IFR(1)=APL7(WS1_1,structure2_1);

WS1_2=transtows_resource_so(structure2_2);
A_IFR(2)=APL7(WS1_2,structure2_2);

WS1_3=transtows_resource_so(structure2_3);
A_IFR(3)=APL7(WS1_3,structure2_3);

%% index8*****  A_SF  ********************************
A_SF=zeros(1,num_strut);
nd=size(structure2_1,2);
ns=size(structure2_1,1);

for e=1:num_strut
    structure=eval(['structure2_',num2str(e)]);
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
    A_SF(e)=max(eig(sf));
end
%% index9*****  A_SF_betweenness  ********************************
% A_SF_between=zeros(1,num_strut);
% 
% for e=1:num_strut
%     structure=eval(['structure2_',num2str(e)]);
%     matfu_1=bipartite2full(structure);
%     [~,edge_b]=betweenness_centrality(sparse(matfu_1));
%     edge_weighted=1./edge_b;
%     edge_weighted(edge_weighted==Inf)=0;
%     graph1=graph(edge_weighted);
%     sf=zeros(nd,nd);
%     for i=1:nd-1
%         for j=i+1:nd
%             sf(i,j)=maxflow(graph1,i+ns,j+ns);
%         end
%     end
%     sf=sf+sf';
%     for i=1:nd
%         sf(i,i)=sum(structure(:,i));
%     end
%     A_SF_between(e)=max(eig(sf));
% end
%% index10*****  A_SF_times  ********************************
A_SF_times=zeros(1,num_strut);

for e=1:num_strut
    times=zeros(ns+nd,ns+nd);
    structure=eval(['structure2_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    graph1=graph(matfu_1);
    for i=1:nd-1
        for j=i+1:nd
            [~,gf]=maxflow(graph1,i+ns,j+ns);
            times=times+full(gf.adjacency);
        end
    end
    times=times+times';
    
    edge_weighted=1./times;
    edge_weighted(edge_weighted==Inf)=0;
    graph1=graph(edge_weighted);
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
    A_SF_times(e)=max(eig(sf));
end
%% index11*****  A_SF_distance  ********************************
A_SF_distance=zeros(1,num_strut);
nd=size(structure2_1,2);
ns=size(structure2_1,1);

for e=1:num_strut
    structure=eval(['structure2_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    graph1=graph(matfu_1);
    sf=zeros(nd,nd);
    num_path_weighted=zeros(ns+nd-1,1);
    for i=1:nd-1
        for j=i+1:nd
            [~,gf]=maxflow(graph1,i+ns,j+ns);
            matrix_flow=full(gf.adjacency);
            num_path_weighted=matrix_power(matrix_flow,ns,nd,i+ns,j+ns);
            sf(i,j)=sum(num_path_weighted);
        end
    end
    sf=sf+sf';
    for i=1:nd
        sf(i,i)=sum(structure(:,i));
    end
    A_SF_distance(e)=max(eig(sf));
end

%% index12*****  A_RM  ********************************
A_RM=zeros(1,num_strut);
nd=size(structure2_1,2);
ns=size(structure2_1,1);
sf=zeros(ns+nd,ns+nd);
for e=1:num_strut
    structure=eval(['structure2_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    for i=1:ns+nd-1
        sf=sf+((ns+nd+1-i)/(ns+nd))*matfu_1^i;
    end
    A_RM(e)=max(eig(sf));
end
%% index13*****  A_connect  ********************************
A_connect=zeros(1,num_strut);
nd=size(structure2_1,2);
ns=size(structure2_1,1);
for e=1:num_strut
    structure=eval(['structure2_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    incidence=mattransf(matfu_1,0);
    L=incidence*incidence';
    eig_sorted=sort(eig(L));
    A_connect(e)=eig_sorted(2);
end
save other2;