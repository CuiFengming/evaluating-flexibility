clc;
clear;

% case 5 ************************************************
D5=[1,1,1,1,1,1,1,1];
num_strut=9;

arc5_1=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8]',[1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,1]'];
structure5_1=sparse(arc5_1(:,1),arc5_1(:,2),ones(length(arc5_1),1));

arc5_2=[[1,1,2,2,3,3,4,4,4,4,5,5,5,5,6,6,7,7,8,8]',[1,2,1,3,2,4,3,4,5,6,3,4,5,6,5,7,6,8,7,8]'];
structure5_2=sparse(arc5_2(:,1),arc5_2(:,2),ones(length(arc5_2),1));

arc5_3=[[1,1,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,8,8]',[1,2,1,2,3,3,4,5,6,3,4,5,6,4,5,6,7,4,5,6,7,7,8,2,8]'];
structure5_3=sparse(arc5_3(:,1),arc5_3(:,2),ones(length(arc5_3),1));

arc5_4=[[1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,7,8,8,8]',[1,2,3,2,3,4,3,4,5,4,5,6,5,6,7,6,7,8,7,8,1,8,1,2]'];
structure5_4=sparse(arc5_4(:,1),arc5_4(:,2),ones(length(arc5_4),1));

arc5_5=[[1,1,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8]',[1,2,2,3,1,3,4,5,1,3,4,6,4,5,6,7,4,5,6,8,5,6,7,8,7,8]'];
structure5_5=sparse(arc5_5(:,1),arc5_5(:,2),ones(length(arc5_5),1));

arc5_6=[[1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8]',[1,2,1,2,3,4,1,2,3,4,3,4,5,6,3,4,5,6,5,6,7,8,5,6,7,8,7,8]'];
structure5_6=sparse(arc5_6(:,1),arc5_6(:,2),ones(length(arc5_6),1));

arc5_7=[[1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8]',[1,2,3,4,2,3,4,5,3,4,5,6,4,5,6,7,5,6,7,8,6,7,8,1,7,8,1,2,8,1,2,3]'];
structure5_7=sparse(arc5_7(:,1),arc5_7(:,2),ones(length(arc5_7),1));

arc5_8=[[1,1,1,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6,7,7,7,8,8,8]',[1,2,3,1,2,4,1,2,3,4,5,6,1,2,3,4,5,6,3,4,5,6,7,8,3,4,5,6,7,8,5,7,8,6,7,8]'];
structure5_8=sparse(arc5_8(:,1),arc5_8(:,2),ones(length(arc5_8),1));

arc5_9=[[1,1,1,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,4,4,4,5,5,5,5,5,5,6,6,6,6,6,6,7,7,7,7,7,7,8,8,8]',[1,2,3,1,2,3,4,5,6,1,2,3,4,5,7,1,2,4,5,6,8,1,2,4,5,7,8,3,4,5,6,7,8,3,4,5,6,7,8,6,7,8]'];
structure5_9=sparse(arc5_9(:,1),arc5_9(:,2),ones(length(arc5_9),1));

m=length(D5);
g=ones(m,m)*0.5;
g=g+diag(diag(g));
q=ones(m,1)*5;


%*****************************************************


%% index1*****  WS_APL  ********************************************
APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径
APL_index1=zeros(1,num_strut);

% WS1_1=transtows(structure5_1);
% APL_index1(1)=APL1(WS1_1);
% 
% WS1_2=transtows(structure5_2);
% APL_index1(2)=APL1(WS1_2);
% 
% WS1_3=transtows(structure5_3);
% APL_index1(3)=APL1(WS1_3);
% 
% WS1_4=transtows(structure5_4);
% APL_index1(4)=APL1(WS1_4);
% 
% WS1_5=transtows(structure5_5);
% APL_index1(5)=APL1(WS1_5);
% 
% WS1_6=transtows(structure5_6);
% APL_index1(6)=APL1(WS1_6);
% 
% WS1_7=transtows(structure5_7);
% APL_index1(7)=APL1(WS1_7);
% 
% WS1_8=transtows(structure5_8);
% APL_index1(8)=APL1(WS1_8);
% 
% WS1_9=transtows(structure5_9);
% APL_index1(9)=APL1(WS1_9);

for e=1:num_strut
    structure=eval(['structure5_',num2str(e)]);
    WS1_1=transtows(structure);
    APL_index1(e)=APL1(WS1_1);
end
%% index2*****  WS_resource_do_APL  ********************************
% APL2=@(F)sum((sum((1-F).^2,1)).^0.5.*std(1-F,0,1)./sum(std(1-F,0,1)));
% APL2=@(F)sum(std(F,0,1)./sum(F));
% APL2=@(F)sum(std(F,0,1)./(sum(F.^2,1)).^0.5);
APL2=@(F)sum(std(F,0,1)./((sum((F).^2,1)).^0.5.*sum(F)));
% APL2=@(F)sum(std(F,0,1)./((sum((F).^2,1)).^0.5))/sum(sum(F));


% APL2=@(F)sum(svd(1-F));
APL_index2=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure5_1);
F=WS2_1*structure5_1;
F(F>1)=1;
APL_index2(1)=APL2(F);

WS2_2=transtows_resource_so(structure5_2);
F=WS2_2*structure5_2;
F(F>1)=1;
APL_index2(2)=APL2(F);

WS2_3=transtows_resource_so(structure5_3);
F=WS2_3*structure5_3;
F(F>1)=1;
APL_index2(3)=APL2(F);

WS2_4=transtows_resource_so(structure5_4);
F=WS2_4*structure5_4;
F(F>1)=1;
APL_index2(4)=APL2(F);

WS2_5=transtows_resource_so(structure5_5);
F=WS2_5*structure5_5;
F(F>1)=1;
APL_index2(5)=APL2(F);

WS2_6=transtows_resource_so(structure5_6);
F=WS2_6*structure5_6;
F(F>1)=1;
APL_index2(6)=APL2(F);

WS2_7=transtows_resource_so(structure5_7);
F=WS2_7*structure5_7;
F(F>1)=1;
APL_index2(7)=APL2(F);

WS2_8=transtows_resource_so(structure5_8);
F=WS2_8*structure5_8;
F(F>1)=1;
APL_index2(8)=APL2(F);

WS2_9=transtows_resource_so(structure5_9);
F=WS2_9*structure5_9;
F(F>1)=1;
APL_index2(9)=APL2(F);
%% index3*****  WS_resource_so_APL  ********************************
APL3=@(WS)mean(mean(distances(digraph(WS))));
APL_index3=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure5_1);
APL_index3(1)=APL3(WS2_1);

WS2_2=transtows_resource_so(structure5_2);
APL_index3(2)=APL3(WS2_2);

WS2_3=transtows_resource_so(structure5_3);
APL_index3(3)=APL3(WS2_3);

WS2_4=transtows_resource_so(structure5_4);
APL_index3(4)=APL3(WS2_4);

WS2_5=transtows_resource_so(structure5_5);
APL_index3(5)=APL3(WS2_5);

WS2_6=transtows_resource_so(structure5_6);
APL_index3(6)=APL3(WS2_6);

WS2_7=transtows_resource_so(structure5_7);
APL_index3(7)=APL3(WS2_7);

WS2_8=transtows_resource_so(structure5_8);
APL_index3(8)=APL3(WS2_8);

WS2_9=transtows_resource_so(structure5_9);
APL_index3(9)=APL3(WS2_9);
%% index4*****  WS_resource_dr_APL  ********************************
APL4=@(WS)mean(mean(distances(digraph(WS))));
APL_index4=zeros(1,num_strut);

WS2_1=transtows_resource_dr(structure5_1);
APL_index4(1)=APL4(WS2_1);

WS2_2=transtows_resource_dr(structure5_2);
APL_index4(2)=APL4(WS2_2);

WS2_3=transtows_resource_dr(structure5_3);
APL_index4(3)=APL4(WS2_3);

WS2_4=transtows_resource_dr(structure5_4);
APL_index4(4)=APL4(WS2_4);

WS2_5=transtows_resource_dr(structure5_5);
APL_index4(5)=APL4(WS2_5);

WS2_6=transtows_resource_dr(structure5_6);
APL_index4(6)=APL4(WS2_6);

WS2_7=transtows_resource_dr(structure5_7);
APL_index4(7)=APL4(WS2_7);

WS2_8=transtows_resource_dr(structure5_8);
APL_index4(8)=APL4(WS2_8);

WS2_9=transtows_resource_dr(structure5_9);
APL_index4(9)=APL4(WS2_9);
%% index5*****  WS_resource_sr_APL  *******************************************
APL5=@(WS)mean(mean(distances(digraph(WS))));
APL_index5=zeros(1,num_strut);

WS2_1=transtows_resource_sr(structure5_1);
APL_index5(1)=APL5(WS2_1);

WS2_2=transtows_resource_sr(structure5_2);
APL_index5(2)=APL5(WS2_2);

WS2_3=transtows_resource_sr(structure5_3);
APL_index5(3)=APL5(WS2_3);

WS2_4=transtows_resource_sr(structure5_4);
APL_index5(4)=APL5(WS2_4);

WS2_5=transtows_resource_sr(structure5_5);
APL_index5(5)=APL5(WS2_5);

WS2_6=transtows_resource_sr(structure5_6);
APL_index5(6)=APL5(WS2_6);

WS2_7=transtows_resource_sr(structure5_7);
APL_index5(7)=APL5(WS2_7);

WS2_8=transtows_resource_sr(structure5_8);
APL_index5(8)=APL5(WS2_8);

WS2_9=transtows_resource_sr(structure5_9);
APL_index5(9)=APL5(WS2_9);
%% index6*****  WS_directed_APL  ********************************
APL6=@(WS)(sum(sum(triu(distances(digraph(WS)),1)))+sum(sum(tril(distances(digraph(WS)),-1))))/(length(WS)*(length(WS)-1));
APL_index6=zeros(1,num_strut);

WS1_1=transtows_degree(structure5_1);
APL_index6(1)=APL6(WS1_1);

WS1_2=transtows_degree(structure5_2);
APL_index6(2)=APL6(WS1_2);

WS1_3=transtows_degree(structure5_3);
APL_index6(3)=APL6(WS1_3);

WS1_4=transtows_degree(structure5_4);
APL_index6(4)=APL6(WS1_4);

WS1_5=transtows_degree(structure5_5);
APL_index6(5)=APL6(WS1_5);

WS1_6=transtows_degree(structure5_6);
APL_index6(6)=APL6(WS1_6);

WS1_7=transtows_degree(structure5_7);
APL_index6(7)=APL6(WS1_7);

WS1_8=transtows_degree(structure5_8);
APL_index6(8)=APL6(WS1_8);

WS1_9=transtows_degree(structure5_9);
APL_index6(9)=APL6(WS1_9);
%% index7*****  A_IFR  ********************************
% APL7=@(WS,structure)max(eig((1-WS^(length(D5)/2)*structure).^2));
% APL7=@(WS,structure)norm(1-WS^1*structure,'fro');
% APL7=@(WS,structure)sum((sum((1-WS^1*structure).^2,1)).^0.5);
% APL7=@(WS,structure)sum((sum((1-(WS^1)*structure).^2,1)).^0.5.*std(1-(WS^1)*structure,0,1)./sum(std(1-(WS^1)*structure,0,1)));
% APL7=@(WS,structure)sum((sum((1-(WS^1)*structure).^2,1)).^0.5.*std((1-(WS^1)*structure).^2,0,1)./sum(std((1-(WS^1)*structure).^2,0,1)));
% APL7=@(WS,structure)sum(sum(structure).*std(1-(WS^1)*structure,0,1));
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./sum((WS*structure).^2,1).^0.5);
% APL7=@(WS,structure)norm(1-WS^1*structure,2);
APL7=@(structure)norm((1-hf(structure,structure.*g)),2);
% APL7=@(structure)sum(sum((1-hf(structure,structure.*g).^2))).^0.5;

A_IFR=zeros(1,num_strut);

A_IFR(1)=APL7(structure5_1);

A_IFR(2)=APL7(structure5_2);

A_IFR(3)=APL7(structure5_3);

A_IFR(4)=APL7(structure5_4);

A_IFR(5)=APL7(structure5_5);

A_IFR(6)=APL7(structure5_6);

A_IFR(7)=APL7(structure5_7);

A_IFR(8)=APL7(structure5_8);

A_IFR(9)=APL7(structure5_9);
%% index8*****  A_SF  ********************************
A_SF=zeros(1,num_strut);
nd=size(structure5_1,2);
ns=size(structure5_1,1);

for e=1:num_strut
    structure=eval(['structure5_',num2str(e)]);
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
%     structure=eval(['structure5_',num2str(e)]);
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
    structure=eval(['structure5_',num2str(e)]);
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
nd=size(structure5_1,2);
ns=size(structure5_1,1);

for e=1:num_strut
    structure=eval(['structure5_',num2str(e)]);
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
nd=size(structure5_1,2);
ns=size(structure5_1,1);
sf=zeros(ns+nd,ns+nd);
for e=1:num_strut
    structure=eval(['structure5_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    for i=1:ns+nd-1
        sf=sf+(1/2)^i*matfu_1^i;
    end
    A_RM(e)=max(eig(sf));
end
%% index13*****  A_connect  ********************************
A_connect=zeros(1,num_strut);
nd=size(structure5_1,2);
ns=size(structure5_1,1);
for e=1:num_strut
    structure=eval(['structure5_',num2str(e)]);
    matfu_1=bipartite2full(structure);
    
    L=diag(sum(matfu_1))-matfu_1;
%     incidence=mattransf(matfu_1,0);
%     L=incidence*incidence';
    eig_sorted=sort(eig(L));
    A_connect(e)=eig_sorted(2);
end
A_IFR_shrinking=[A_IFR(1),A_IFR(3:end)];

LiuandLi=[0.420,0.560,0.590,0.620,0.670,0.910,1,1.27;
    3.336,5.086,4.719,5.376,5.555,7.25,8.234,10.148;
    0.0600,0.0700,0.250,0.0900,0.0800,0.590,0.250,0.520;
    2.14,1.55,1.45,1.43,1.38,1.20,1.19,1.12;
    1.49,1,0.920,0.940,0.870,0.710,0.700,0.630];%Liu and Li(2012)
allshrinking=[A_IFR_shrinking;LiuandLi];

save allshrinking;

[~,b]=sort(allshrinking(end,:));
plot(allshrinking(end,b),[allshrinking([1 3],b);allshrinking(4,b)*10]);