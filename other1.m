clc;
clear;

% case 1 ************************************************
D1=[2,1,1,1,1,1,1,1,0.5,0.5];
num_strut=4;

arc1_1=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]',[1,2,1,2,1,3,1,10,4,5,5,6,6,7,7,8,8,9,3,4]'];
structure1_1=sparse(arc1_1(:,1),arc1_1(:,2),ones(length(arc1_1),1));

arc1_2=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]',[1,2,1,3,1,4,1,5,2,3,4,6,5,7,6,8,7,9,8,10]'];
structure1_2=sparse(arc1_2(:,1),arc1_2(:,2),ones(length(arc1_2),1));

arc1_3=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]',[1,2,1,3,1,4,1,10,2,5,3,6,4,7,5,8,6,8,7,9]'];
structure1_3=sparse(arc1_3(:,1),arc1_3(:,2),ones(length(arc1_3),1));

arc1_4=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10]',[1,2,1,3,1,9,1,10,2,4,4,5,5,6,6,7,7,8,3,8]'];
structure1_4=sparse(arc1_4(:,1),arc1_4(:,2),ones(length(arc1_4),1));

ns=size(structure1_1,1);
nd=size(structure1_1,2);
%*****************************************************

%% index1*****  WS_APL  ********************************************
APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径
APL_index1=zeros(1,num_strut);

WS1_1=transtows(structure1_1);
APL_index1(1)=APL1(WS1_1);

WS1_2=transtows(structure1_2);
APL_index1(2)=APL1(WS1_2);

WS1_3=transtows(structure1_3);
APL_index1(3)=APL1(WS1_3);

WS1_4=transtows(structure1_4);
APL_index1(4)=APL1(WS1_4);
%% index2*****  WS_resource_do_APL  ********************************
APL2=@(F)sum(std(F,0,1)./((sum((F).^2,1)).^0.5.*sum(F)));
% APL2=@(F)sum((std(F,0,1)./sum(F)).^2);
% APL2=@(F)sum(std(F,0,1)./sum(F));
% APL2=@(F)sum(std(F,0,1)./(sum(F.^2,1)).^0.5);
% APL2=@(F)sum(svd(1-F));

% APL2=@(F)sum(sum(1-F));
APL_index2=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure1_1);
F1=WS2_1*structure1_1;
% F1(structure1_1==0)=0;
APL_index2(1)=APL2(F1);

WS2_2=transtows_resource_so(structure1_2);
F2=WS2_2*structure1_2;
% F2(structure1_2==0)=0;
APL_index2(2)=APL2(F2);

WS2_3=transtows_resource_so(structure1_3);
F3=WS2_3*structure1_3;
% F3(structure1_3==0)=0;
APL_index2(3)=APL2(F3);

WS2_4=transtows_resource_so(structure1_4);
F4=WS2_4*structure1_4;
% F4(structure1_4==0)=0;
APL_index2(4)=APL2(F4);
%% index3*****  WS_resource_so_APL  ********************************
APL3=@(WS)mean(mean(distances(digraph(WS))));
APL_index3=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure1_1);
APL_index3(1)=APL3(WS2_1);

WS2_2=transtows_resource_so(structure1_2);
APL_index3(2)=APL3(WS2_2);

WS2_3=transtows_resource_so(structure1_3);
APL_index3(3)=APL3(WS2_3);

WS2_4=transtows_resource_so(structure1_4);
APL_index3(4)=APL3(WS2_4);
%% index4*****  WS_resource_dr_APL  ********************************
APL4=@(WS)mean(mean(distances(digraph(WS))));
APL_index4=zeros(1,num_strut);

WS2_1=transtows_resource_dr(structure1_1);
APL_index4(1)=APL4(WS2_1);

WS2_2=transtows_resource_dr(structure1_2);
APL_index4(2)=APL4(WS2_2);

WS2_3=transtows_resource_dr(structure1_3);
APL_index4(3)=APL4(WS2_3);

WS2_4=transtows_resource_dr(structure1_4);
APL_index4(4)=APL4(WS2_4);
%% index5*****  WS_resource_sr_APL  *******************************************
APL5=@(WS)mean(mean(distances(digraph(WS))));
APL_index5=zeros(1,num_strut);

WS2_1=transtows_resource_sr(structure1_1);
APL_index5(1)=APL5(WS2_1);

WS2_2=transtows_resource_sr(structure1_2);
APL_index5(2)=APL5(WS2_2);

WS2_3=transtows_resource_sr(structure1_3);
APL_index5(3)=APL5(WS2_3);

WS2_4=transtows_resource_sr(structure1_4);
APL_index5(4)=APL5(WS2_4);
%% index6*****  WS_directed_APL  ********************************
APL6=@(WS)(sum(sum(triu(distances(digraph(WS)),1)))+sum(sum(tril(distances(digraph(WS)),-1))))/(length(WS)*(length(WS)-1));
APL_index6=zeros(1,num_strut);

WS1_1=transtows_degree(structure1_1);
APL_index6(1)=APL6(WS1_1);

WS1_2=transtows_degree(structure1_2);
APL_index6(2)=APL6(WS1_2);

WS1_3=transtows_degree(structure1_3);
APL_index6(3)=APL6(WS1_3);

WS1_4=transtows_degree(structure1_4);
APL_index6(4)=APL6(WS1_4);
%% index7*****  A_IFR  ********************************
% APL7=@(WS,structure)sum(sum((1-WS^(length(D1)/2)*structure).^2)); 迭代次数为一半
% APL7=@(WS,structure)sum(sum((1-WS^1*structure).^2)); 迭代次数为1
% APL7=@(WS,structure) 1-pdist([reshape(WS^0*structure,ns*nd,1),ones(ns*nd,1)]','cosine');%余弦夹角
APL7=@(WS,structure)norm(1-WS^1*structure,2);
% APL7=@(WS,structure)sum((sum((1-(WS^1)*structure).^2,1)).^0.5.*std(1-(WS^1)*structure,0,1)./sum(std(1-(WS^1)*structure,0,1)));
% APL7=@(WS,structure)sum(std(1-(WS^1)*structure,0,1));
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./sum((WS*structure).^2,1).^0.5);
A_IFR=zeros(1,num_strut);

WS1_1=transtows_resource_so(structure1_1);
A_IFR(1)=APL7(WS1_1,structure1_1);

WS1_2=transtows_resource_so(structure1_2);
A_IFR(2)=APL7(WS1_2,structure1_2);

WS1_3=transtows_resource_so(structure1_3);
A_IFR(3)=APL7(WS1_3,structure1_3);

WS1_4=transtows_resource_so(structure1_4);
A_IFR(4)=APL7(WS1_4,structure1_4);

%% index8*****  A_SF  ********************************
A_SF=zeros(1,num_strut);
nd=size(structure1_1,2);
ns=size(structure1_1,1);

for e=1:num_strut
    structure=eval(['structure1_',num2str(e)]);
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
%     structure=eval(['structure1_',num2str(e)]);
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
%另一个实验
% D_matrix=repmat(D1,ns,1);
% APL7=@(WS,structure)max(eig((1*sum(D1)/nd-D_matrix.*WS^(length(D1)/2)*structure).^2));
% A_IFR_D=zeros(1,num_strut);
% 
% WS1_1=transtows_resource_so(structure1_1);
% A_IFR_D(1)=APL7(WS1_1,structure1_1);
% 
% WS1_2=transtows_resource_so(structure1_2);
% A_IFR_D(2)=APL7(WS1_2,structure1_2);
% 
% WS1_3=transtows_resource_so(structure1_3);
% A_IFR_D(3)=APL7(WS1_3,structure1_3);
% 
% WS1_4=transtows_resource_so(structure1_4);
% A_IFR_D(4)=APL7(WS1_4,structure1_4);
% %另一个实验：方差最小化
% A_IFR_D=zeros(1,num_strut);
% APL7=@(WS,structure)var(WS^(length(D1)/2)*structure./repmat(sum(structure),ns,1)*D1');
% WS1_1=transtows_resource_so(structure1_1);
% A_IFR_D(1)=APL7(WS1_1,structure1_1);
% 
% WS1_2=transtows_resource_so(structure1_2);
% A_IFR_D(2)=APL7(WS1_2,structure1_2);
% 
% WS1_3=transtows_resource_so(structure1_3);
% A_IFR_D(3)=APL7(WS1_3,structure1_3);
% 
% WS1_4=transtows_resource_so(structure1_4);
% A_IFR_D(4)=APL7(WS1_4,structure1_4);

%另一个实验：dummy relation matrix 求和后与需求的皮尔逊系数
% A_IFR_D=zeros(1,num_strut);
% APL7=@(WS)corr(sum(WS,2),D1');
% WS1_1=transtows_resource_do(structure1_1);
% A_IFR_D(1)=APL7(WS1_1);
% 
% WS1_2=transtows_resource_do(structure1_2);
% A_IFR_D(2)=APL7(WS1_2);
% 
% WS1_3=transtows_resource_do(structure1_3);
% A_IFR_D(3)=APL7(WS1_3);
% 
% WS1_4=transtows_resource_do(structure1_4);
% A_IFR_D(4)=APL7(WS1_4);

%另一个实验：dummy relation matrix 的行方差与需求的皮尔逊系数
% A_IFR_D=zeros(1,num_strut);
% APL7=@(WS)corr(std(WS,0,2),D1');
% WS1_1=transtows_resource_do(structure1_1);
% A_IFR_D(1)=APL7(WS1_1);
% 
% WS1_2=transtows_resource_do(structure1_2);
% A_IFR_D(2)=APL7(WS1_2);
% 
% WS1_3=transtows_resource_do(structure1_3);
% A_IFR_D(3)=APL7(WS1_3);
% 
% WS1_4=transtows_resource_do(structure1_4);
% A_IFR_D(4)=APL7(WS1_4);

%另一个实验：dummy relation matrix 的行方差求和
A_IFR_D=zeros(1,num_strut);
APL7=@(WS)sum(std(WS,0,2));
WS1_1=transtows_resource_do(structure1_1);
A_IFR_D(1)=APL7(WS1_1);

WS1_2=transtows_resource_do(structure1_2);
A_IFR_D(2)=APL7(WS1_2);

WS1_3=transtows_resource_do(structure1_3);
A_IFR_D(3)=APL7(WS1_3);

WS1_4=transtows_resource_do(structure1_4);
A_IFR_D(4)=APL7(WS1_4);
%% index10*****  A_SF_times  ********************************
A_SF_times=zeros(1,num_strut);

for e=1:num_strut
    times=zeros(ns+nd,ns+nd);
    structure=eval(['structure1_',num2str(e)]);
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
nd=size(structure1_1,2);
ns=size(structure1_1,1);

for e=1:num_strut
    structure=eval(['structure1_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    graph1=graph(matfu_1);
    sf=zeros(nd,nd);
    num_path_weighted=zeros(ns+nd-1,1);
    for i=1:nd-1
        for j=i+1:nd
            [~,gf]=maxflow(graph1,i+ns,j+ns);
            matrix_flow=full(gf.adjacency);
            num_path_weighted=flow_find(gf,ns,nd,i+ns,j+ns);
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
nd=size(structure1_1,2);
ns=size(structure1_1,1);
sf=zeros(ns+nd,ns+nd);
for e=1:num_strut
    structure=eval(['structure1_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    for i=1:ns+nd-1
        sf=sf+((ns+nd+1-i)/(ns+nd))*matfu_1^i;
    end
    A_RM(e)=max(eig(sf));
end

%% index13*****  A_connect  ********************************
A_connect=zeros(1,num_strut);
nd=size(structure1_1,2);
ns=size(structure1_1,1);
for e=1:num_strut
    structure=eval(['structure1_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    incidence=mattransf(matfu_1,0);
    L=incidence*incidence';
    eig_sorted=sort(eig(L));
    A_connect(e)=eig_sorted(2);
end
save other1;