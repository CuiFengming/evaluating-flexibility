clc;
clear;

load data1_119;
load other1;

M=size(wait,1); %仿真试验次数
num_structure=size(wait,2); %结构的种类

%对wait的内容进行更正
wait=0.*wait;
for rflag=1:M
    for sflag=1:num_structure
        arrival_served2=arrival_served_record{rflag,sflag};
        [~,customer_last]=min(arrival_served2(:,end));
        N_right=min([N,customer_last]);
        wait(rflag,sflag)=mean(arrival_served2(1500:N_right,2));
    end
end

pearson=corrcoef([wait;APL_index1]');
p1_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;APL_index2]');
p2_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;APL_index3]');
p3_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;APL_index4]');
p4_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;APL_index5]');
p5_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;APL_index6]');
p6_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;A_IFR]');
p7_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;A_SF]');
p8_bar=mean(pearson(end,1:end-1));
% 
% pearson=corrcoef([wait;A_IFR_D]');
% p9_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;A_SF_times]');
p10_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;A_SF_distance]');
p11_bar=mean(pearson(end,1:end-1));

pearson=corrcoef([wait;A_RM]');
p12_bar=mean(pearson(end,1:end-1));

