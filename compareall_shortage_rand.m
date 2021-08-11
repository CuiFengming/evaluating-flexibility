clc;
clear;
num_s=2;
% kendall_ave=zeros(2,4*4);
spearman_ave=zeros(2,4*4);
n=[20,20,40,40];
k=[5,10,5,10];
num_strut=6;
A_IFR=zeros(1,6);
APL_index1=A_IFR;
A_SF=A_IFR;
A_connect=A_IFR;
APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径

for whichdata=1:1
    s1=ernet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1)); %ER图，保证左侧连边个数随机连
    s2=wsnet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1),0.5); %链式结构随机重连，左侧相同
    s3=wsnet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1),0.2); %链式结构随机重连，左侧相同
    s4=randnet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1)); %随机链接，保证左右连边个数相等
    s5=rewritingnet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1)); %二二交换，左右相同
    s6=chainnet(k(whichdata)*ones(n(whichdata),1),k(whichdata)*ones(n(whichdata),1)); %连试图，左右相同
    for i=1:6
        s=eval(['s',num2str(i)]);
%         A_IFR(i)=norm(1-log(transtows_resource_so(s)*s+1),2);
        A_IFR(i)=norm(3/8-transtows_resource_so(s)*s,2);
        APL_index1(i)=APL1(transtows(s));
        A_SF(i)=sffunc(s);
        A_connect(i)=expfunc(s);
    end
    eval(['structure',num2str(whichdata),'_1=s1;']);
    eval(['structure',num2str(whichdata),'_2=s2;']);
    eval(['structure',num2str(whichdata),'_3=s3;']);
    eval(['structure',num2str(whichdata),'_4=s4;']);
    eval(['structure',num2str(whichdata),'_5=s5;']);
    eval(['structure',num2str(whichdata),'_6=s6;']);
    shortage=zeros(num_s,num_strut);
    D=ones(1,n(whichdata));
    C=D;
    for i=1:num_strut
        struct_this=eval(['structure',num2str(whichdata),'_',num2str(i)]);
        for j=1:num_s
%             D_rand=2*D.*tracnorm(length(D),0.5,1,0,1);%截断正态分布
            D_rand=2*D.*rand(1,length(D));%均匀分布
            shortage(j,i)=findshort(struct_this,D_rand,C);
        end
    end
    spearman_ave(1,4*(whichdata-1)+1)=mean(corr(A_IFR',mean(shortage)','type','spearman'));
    spearman_ave(1,4*(whichdata-1)+2)=mean(corr(APL_index1',mean(shortage)','type','spearman'));
    spearman_ave(1,4*(whichdata-1)+3)=mean(corr(A_SF',mean(shortage)','type','spearman'));
    spearman_ave(1,4*(whichdata-1)+4)=mean(corr(A_connect',mean(shortage)','type','spearman'));
    
    shortage=zeros(num_s,num_strut);
    for i=1:num_strut
        struct_this=eval(['structure',num2str(whichdata),'_',num2str(i)]);
        for j=1:num_s
            D_rand=2*D.*tracnorm(length(D),0.5,2,0,1);%截断正态分布
%             D_rand=2*D.*rand(1,length(D));%均匀分布
            shortage(j,i)=findshort(struct_this,D_rand,C);
        end
    end
    spearman_ave(2,4*(whichdata-1)+1)=mean(corr(A_IFR',mean(shortage)','type','spearman'));
    spearman_ave(2,4*(whichdata-1)+2)=mean(corr(APL_index1',mean(shortage)','type','spearman'));
    spearman_ave(2,4*(whichdata-1)+3)=mean(corr(A_SF',mean(shortage)','type','spearman'));
    spearman_ave(2,4*(whichdata-1)+4)=mean(corr(A_connect',mean(shortage)','type','spearman'));
end