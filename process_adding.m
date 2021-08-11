clc;
clear;

exam=[[1,1,1,2,2,3,3,3]',[1,2,4,2,3,2,3,4]'];
structure0=sparse(exam(:,1),exam(:,2),ones(length(exam),1));
% WS_exam=transtows_resource(structure0);

num_strut=8;

arc1=[[1,2,3,4,5,6,2]',[1,2,3,4,5,6,1]'];
structure1=sparse(arc1(:,1),arc1(:,2),ones(length(arc1),1));

arc2=[[1,2,3,4,5,6,2,3]',[1,2,3,4,5,6,1,2]'];
structure2=sparse(arc2(:,1),arc2(:,2),ones(length(arc2),1));

arc3=[[1,2,3,4,5,6,2,3,4]',[1,2,3,4,5,6,1,2,3]'];
structure3=sparse(arc3(:,1),arc3(:,2),ones(length(arc3),1));

arc4=[[1,2,3,4,5,6,2,3,4,5]',[1,2,3,4,5,6,1,2,3,4]'];
structure4=sparse(arc4(:,1),arc4(:,2),ones(length(arc4),1));

arc5=[[1,2,3,4,5,6,2,3,4,5,6]',[1,2,3,4,5,6,1,2,3,4,5]'];
structure5=sparse(arc5(:,1),arc5(:,2),ones(length(arc5),1));

arc6=[[1,2,3,4,5,6,2,3,4,5,6,1]',[1,2,3,4,5,6,1,2,3,4,5,6]'];
structure6=sparse(arc6(:,1),arc6(:,2),ones(length(arc6),1));

arc7=[[1,2,3,4,5,6,2,3,4,5,6,1,3]',[1,2,3,4,5,6,1,2,3,4,5,6,1]'];
structure7=sparse(arc7(:,1),arc7(:,2),ones(length(arc7),1));

arc8=[[1,2,3,4,5,6,2,3,4,5,6,1,3,4]',[1,2,3,4,5,6,1,2,3,4,5,6,1,2]'];
structure8=sparse(arc8(:,1),arc8(:,2),ones(length(arc8),1));

% arc9=[[1,2,3,4,5,6,2,3,4,5,6,1,3,7]',[1,2,3,4,5,6,1,2,3,4,5,6,1,2]'];
% structure9=sparse(arc9(:,1),arc9(:,2),ones(length(arc9),1));

% none % APL7=@(WS,structure)max(eig((1-(WS^4)*structure).^2));
% APL7=@(WS,structure)sum(vecnorm(WS,2,1),2);
APL7=@(WS,structure)norm(1-WS*structure,'fro');


% APL7=@(WS,structure)sum(sum((1-WS*structure).^2).^0.5);
% APL7=@(WS,structure)sum(sum((1-WS*structure).^2));
% none % APL7=@(WS,structure)sum((sum((1-(WS^1)*structure).^2,1)).^0.5); 
% none % APL7=@(WS,structure)sum((sum((1-(WS*structure)).^2,1)).^0.5.*std((1-(WS^1)*structure),0,1)./sum(std(1-(WS^1)*structure,0,1))); 
% none % APL7=@(WS,structure)sum((sum((((1-(WS*structure))>0).*(1-(WS*structure))).^2,1)).^0.5.*std((((1-(WS*structure))>0).*(1-(WS*structure))),0,1)./sum(std((((1-(WS*structure))>0).*(1-(WS*structure))),0,1)));
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./sum((WS*structure).^2,1).^0.5);
% APL7=@(WS,structure)sum(std(WS*structure,0,1)./(sum((WS*structure).^2,1).^0.5.*sum(structure)));

A_IFR=zeros(1,num_strut);

WS2_1=transtows_resource_so(structure1);

WS2_2=transtows_resource_so(structure2);

WS2_3=transtows_resource_so(structure3);  

WS2_4=transtows_resource_so(structure4);

WS2_5=transtows_resource_so(structure5);

WS2_6=transtows_resource_so(structure6);

WS2_7=transtows_resource_so(structure7);

WS2_8=transtows_resource_so(structure8);


A_IFR(1)=APL7(WS2_1,structure1);
A_IFR(2)=APL7(WS2_2,structure2);
A_IFR(3)=APL7(WS2_3,structure3);
A_IFR(4)=APL7(WS2_4,structure4);
A_IFR(5)=APL7(WS2_5,structure5);
A_IFR(6)=APL7(WS2_6,structure6);
A_IFR(7)=APL7(WS2_7,structure7);
A_IFR(8)=APL7(WS2_8,structure8);


% [~,~,~,~,~,A_IFR(1)]=fgf(structure1);
% [~,~,~,~,~,A_IFR(2)]=fgf(structure2);
% [~,~,~,~,~,A_IFR(3)]=fgf(structure3);
% [~,~,~,~,~,A_IFR(4)]=fgf(structure4);
% [~,~,~,~,~,A_IFR(5)]=fgf(structure5);
% [~,~,~,~,~,A_IFR(6)]=fgf(structure6);
% [~,~,~,~,~,A_IFR(7)]=fgf(structure7);
% [~,~,~,~,~,A_IFR(8)]=fgf(structure8);

%% index13*****  A_connect  ********************************
A_connect=zeros(1,num_strut);

APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径
APL_index1=zeros(1,num_strut);

nd=size(structure1,2);
ns=size(structure1,1);
for e=1:num_strut
    structure=eval(['structure',num2str(e)]);
    matfu_1=bipartite2full(structure);
    
%     L=diag(sum(matfu_1))-matfu_1;
    incidence=mattransf(matfu_1,0);
    L=incidence*incidence';
    eig_sorted=sort(eig(L));
    A_connect(e)=eig_sorted(2);
    
    WS1_1=transtows(structure);
    APL_index1(e)=APL1(WS1_1);
end

%% index8*****  A_SF  ********************************
A_SF=zeros(1,num_strut);
nd=size(structure1,2);
ns=size(structure1,1);

for e=1:num_strut
    structure=eval(['structure',num2str(e)]);
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
%%
k_IFR=diff(A_IFR);
k_SF=diff(A_SF);
k_connect=diff(A_connect);
k_APL=diff(APL_index1);

value=[A_IFR;A_SF;A_connect];
k=[k_IFR;k_SF;k_connect];

% value=zscore(value);
% k=zscore(k);

F3=WS2_3*structure3;
F4=WS2_4*structure4;
F5=WS2_5*structure5;
F6=WS2_6*structure6;
F7=WS2_7*structure7;

gap3=1-F3;
gap4=1-F4;
gap5=1-F5;
gap6=1-F6;
gap7=1-F7;
% plot(1:8,A_IFR);
% hold on
% plot(1:7,k);
% hold off
% plotyy(1:9,A_IFR,2:9,k./A_IFR(1:end-1));
% plotyy(1:8,A_IFR(1:end-1),2:8,k(1:end-1)./A_IFR(1:end-2));
figure;
subplot(2,2,1)
yyaxis left
plot(1:8,A_IFR,'-*');
yyaxis right
plot(2:8,k_IFR,'-o');
title('FG index')

subplot(2,2,2)
yyaxis left
plot(1:8,A_SF,'-*');
yyaxis right
plot(2:8,k_SF,'-o');
title('SF index')

subplot(2,2,3)
yyaxis left
plot(1:8,APL_index1,'-*');
yyaxis right
plot(2:8,k_APL,'-o');
title('APL index')

subplot(2,2,4)
yyaxis left
plot(1:8,A_connect,'-*');
yyaxis right
plot(2:8,k_connect,'-o');
title('Expansion index')
% plot(1:8,value);
% plot(2:8,k);
% createfigure(1:8,A_IFR,2:8,k)