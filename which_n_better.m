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

load test1;
%*****************************************************
delta7_mean=zeros(1,length(D1));
rate_correct7=zeros(1,length(D1));
for nii=1:length(D1)

APL7=@(WS,structure)norm(1-WS^1*structure,2);
A_IFR=zeros(1,num_strut);

WS1_1=transtows_resource_so(structure1_1);
A_IFR(1)=APL7(WS1_1,structure1_1);

WS1_2=transtows_resource_so(structure1_2);
A_IFR(2)=APL7(WS1_2,structure1_2);

WS1_3=transtows_resource_so(structure1_3);
A_IFR(3)=APL7(WS1_3,structure1_3);

WS1_4=transtows_resource_so(structure1_4);
A_IFR(4)=APL7(WS1_4,structure1_4);



N=size(wait,1); %仿真试验次数
num_structure=size(wait,2); %结构的种类
num_pair=nchoosek(num_structure,2); %两两比较的总次数
num_cp=N*num_pair;
pair_index=zeros(num_cp,2); %两两比较的所有排列组合
pair_result=zeros(num_cp,2); %两两比较的仿真结果
for i=1:N %把所有的两两比较仿真结果排列成一个大矩阵
    temp=nchoosek(1:num_structure,2);
    pair_index(((i-1)*num_pair+1):(i*num_pair),:)=temp;
    temp1=wait(i,:);
    pair_result(((i-1)*num_pair+1):(i*num_pair),:)=temp1(temp);
end

[~,better0]=min(pair_result,[],2);

[~,better7]=min(A_IFR(pair_index),[],2);


difference_rate=abs(pair_result(:,1)-pair_result(:,2))./min(pair_result,[],2);
pair_valid_th=find(difference_rate>0.001);

temp=(better7==better0);
rate_correct7(nii)=sum(temp(pair_valid_th))/length(pair_valid_th);
delta7=difference_rate(pair_valid_th).*(1-temp(pair_valid_th));
delta7_mean(nii)=mean(delta7);

end
% temp=(better13==better0);
% rate_correct13=sum(temp(pair_valid_th))/length(pair_valid_th);
% delta13=difference_rate(pair_valid_th).*(1-temp(pair_valid_th));