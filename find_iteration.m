clc;
clear;
t=6;
t_index=[1,2,5,10,20,50];
spearman1=zeros(20,t);
pearson1=spearman1;
spearman2=pearson1;
pearson2=spearman2;
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
t=6;
for tt=1:t
    temp=A_IFRall(t_index(tt),:);
    spearman1((whichdata-1)*4+n,tt)=(corr(temp',wait','type','spearman'));
    pearson1((whichdata-1)*4+n,tt)=(corr(temp',wait','type','pearson'));  
end
n=n+1;
            end
        end
    end
end

% plot([pearson1;spearman1]');
% legend('$\overline{\rho}$','$\rho$','interpreter','latex');
% axis([0 t 0 1]);