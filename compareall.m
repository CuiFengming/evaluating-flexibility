clc;
clear;

kendall_ave=zeros(2*2*1,5*4);
spearman_ave=zeros(2*2*1,5*4);
pk=spearman_ave;
pp=pk;
pearson_ave=zeros(2*2*1,5*4);

for whichdata=1:5
    
    load(['other',num2str(whichdata),'.mat']);
    cvcv_service=[1,2];
    cvcv_arrival=[1,2];
    uu_arrival=[7];

    num_structure=length(A_IFR); %结构的种类

    n=1;
    for ii=1:2
        for jj=1:2
            for mm=1:1
                dataloaded=['d',num2str(whichdata),'_',num2str(cvcv_service(ii)),num2str(cvcv_arrival(jj)),num2str(uu_arrival(mm)),'.mat'];
    %             dataloaded=['d',num2str(whichdata),'_',num2str(cvcv_service(ii)),num2str(cvcv_arrival(jj)),num2str(uu_arrival(mm)),'.mat'];
                load(dataloaded);
                waitl=max(wait);
                wait=mean(wait);%尝试！！！！可能需要删除
%                 kendall_ave(n,4*(whichdata-1)+1)=mean(corr(A_IFR',waitl','type','spearman'));
%                 kendall_ave(n,4*(whichdata-1)+2)=mean(corr(APL_index1',waitl','type','spearman'));
%                 kendall_ave(n,4*(whichdata-1)+3)=mean(corr(A_SF',waitl','type','spearman'));
%                 kendall_ave(n,4*(whichdata-1)+4)=mean(corr(A_connect',waitl','type','spearman'));

                [spearman_ave(n,4*(whichdata-1)+1),pk(n,4*(whichdata-1)+1)]=(corr(A_IFR',wait','type','spearman'));
                [spearman_ave(n,4*(whichdata-1)+2),pk(n,4*(whichdata-1)+2)]=(corr(APL_index1',wait','type','spearman'));
                [spearman_ave(n,4*(whichdata-1)+3),pk(n,4*(whichdata-1)+3)]=(corr(A_SF',wait','type','spearman'));
                [spearman_ave(n,4*(whichdata-1)+4),pk(n,4*(whichdata-1)+4)]=(corr(A_connect',wait','type','spearman'));

                [pearson_ave(n,4*(whichdata-1)+1),pp(n,4*(whichdata-1)+1)]=(corr(A_IFR',wait','type','pearson'));
                [pearson_ave(n,4*(whichdata-1)+2),pp(n,4*(whichdata-1)+2)]=(corr(APL_index1',wait','type','pearson'));
                [pearson_ave(n,4*(whichdata-1)+3),pp(n,4*(whichdata-1)+3)]=(corr(A_SF',wait','type','pearson'));
                [pearson_ave(n,4*(whichdata-1)+4),pp(n,4*(whichdata-1)+4)]=(corr(A_connect',wait','type','pearson'));
                n=n+1;
            end
        end
    end

end
a1=[];
a2=[];
a3=[];
ap1=[];
ap2=[];
for i=1:5
    a1=[a1;spearman_ave(:,4*(i-1)+1:4*(i-1)+4)];
    a2=[a2;pearson_ave(:,4*(i-1)+1:4*(i-1)+4)];
%     a3=[a3;kendall_ave(:,4*(i-1)+1:4*(i-1)+4)];
%     ap1=[ap1;pk(:,4*(i-1)+1:4*(i-1)+4)];
%     ap2=[ap2;pp(:,4*(i-1)+1:4*(i-1)+4)];
end