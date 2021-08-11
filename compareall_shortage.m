clc;
clear;
num_s=3000;
% kendall_ave=zeros(2,5*4);
spearman_ave=zeros(2,5*4);
pearson_ave=zeros(2,5*4);
for whichdata=1:5
    
    load(['other',num2str(whichdata),'.mat']);
    D=eval(['D',num2str(whichdata)]);
    C=0*D+1;
    num_structure=length(A_IFR); %结构的种类
    shortage=zeros(num_s,num_strut);
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
    
    pearson_ave(1,4*(whichdata-1)+1)=mean(corr(A_IFR',mean(shortage)','type','pearson'));
    pearson_ave(1,4*(whichdata-1)+2)=mean(corr(APL_index1',mean(shortage)','type','pearson'));
    pearson_ave(1,4*(whichdata-1)+3)=mean(corr(A_SF',mean(shortage)','type','pearson'));
    pearson_ave(1,4*(whichdata-1)+4)=mean(corr(A_connect',mean(shortage)','type','pearson'));
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
    
    pearson_ave(2,4*(whichdata-1)+1)=mean(corr(A_IFR',mean(shortage)','type','pearson'));
    pearson_ave(2,4*(whichdata-1)+2)=mean(corr(APL_index1',mean(shortage)','type','pearson'));
    pearson_ave(2,4*(whichdata-1)+3)=mean(corr(A_SF',mean(shortage)','type','pearson'));
    pearson_ave(2,4*(whichdata-1)+4)=mean(corr(A_connect',mean(shortage)','type','pearson'));
end

a1=[];
a2=[];
a3=[];
ap1=[];
ap2=[];
for i=1:5
    a1=[a1;spearman_ave(:,4*(i-1)+1:4*(i-1)+4)];
    a2=[a2;pearson_ave(:,4*(i-1)+1:4*(i-1)+4)];
end