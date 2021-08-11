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

% %***********************************************************
% APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));
% APL_index1=zeros(1,num_strut);
% 
% WS1_1=transtows(structure2_1);
% APL_index1(1)=APL1(WS1_1);
% 
% WS1_2=transtows(structure2_2);
% APL_index1(2)=APL1(WS1_2);
% 
% WS1_3=transtows(structure2_3);
% APL_index1(3)=APL1(WS1_3);
% 
% %*********************************
% APL2=@(WS)mean(mean(distances(digraph(WS))));
% APL_index2=zeros(1,num_strut);
% 
% WS2_1=transtows_resource(structure2_1);
% APL_index2(1)=APL2(WS2_1);
% 
% WS2_2=transtows_resource(structure2_2);
% APL_index2(2)=APL2(WS2_2);
% 
% WS2_3=transtows_resource(structure2_3);
% APL_index2(3)=APL2(WS2_3);
% 
% [a,b]=sort(APL_index1);
% [c,d]=sort(APL_index2);
% [b;d]

%������������������������������������������������������������������������������
% CV=1 **************************************************
% total_time=5000;

%�ܷ������
% N=50000; 

cva=[1,2];
cvs=[1,2];
us=[7];



for iiii=1:2
    for jjjj=1:2
        for kkkk=1:1

% upperbound_arrival=total_time*max(D1)*1.5;
upperbound_arrival=23000;
N=20000;
Nwarm=1500;
arrival=zeros(size(D2,1),upperbound_arrival);

%arrival cv=1;serve cv=1;server u=0.9;
cv_arrival=cva(iiii);
cv_serve=cvs(jjjj);
u_serve=0.7;


alpha_arrival=1/(cv_arrival^2);
alpha_serve=1/(cv_serve^2);
beta_serve=u_serve*(cv_serve^2);

num_demand=max(arc2_1(:,2));
num_staff=max(arc2_1(:,1));

%�ظ����鿪ʼ______________________________________________________________
num_repeat=30;
wait=zeros(num_repeat,num_strut);
arrival_served_record=cell(num_repeat,num_strut);

for rflag=1:num_repeat
for i=1:num_demand
    arrival(i,:)=gamrnd(alpha_arrival,1/D2(i)/alpha_arrival,1,upperbound_arrival);
    arrival(i,:)=cumsum(arrival(i,:));
end

%����������ĵ���ϲ���һ�𣬵���һ��������
arrival_total=arrival(1,:);
arrival_index=ones(1,upperbound_arrival);
for i=2:num_demand
    arrival_total=[arrival_total,arrival(i,:)];
    arrival_index=[arrival_index,ones(1,upperbound_arrival)*i];
end
[arrival_sorted,index_sorted]=sort(arrival_total);
arrival_index_sorted=arrival_index(index_sorted);

arrival_served=zeros(length(arrival_sorted),6);%1����ʱ��㣻2�ȴ�ʱ��Σ�3����ʱ��Σ�4�뿪ʱ��㣻5���󵽴��ţ�6����Ա�����
arrival_served(:,1)=arrival_sorted';
arrival_served(:,5)=arrival_index_sorted';
arrival_served(:,3)=gamrnd(alpha_serve,beta_serve,1,length(arrival_sorted));%����ʱ���Ƕ���
arrival_served=arrival_served(1:upperbound_arrival+Nwarm,:);
%��ʼÿһ���ṹ�ķ�����㣬����ȴ�ʱ��_______________________________

for sflag=1:num_strut
arrival_served2=arrival_served;
arrival_flag=1;
time_flag=0;
%����ÿ��������ŶӶ��У���һ�������飬��ʾ���С��ڶ������Ŷ�����
queue=cell(1,num_demand);
for i=1:num_demand
    queue{i}=[];
end
length_queue=zeros(num_demand,1);

%����ÿ��Ա��Ŀǰ��״̬
isbusy=false(num_staff,1);
time_avlb=zeros(num_staff,1);

while(sum(arrival_served2(:,end)>0)<=N+Nwarm) %arrival_flag��Ŀǰ����ĵ�x��
    structure_this=eval(['structure2_',num2str(sflag)]);
%��ʼ״̬��������еķ����߶����У��򵽴����ϵͳ��
if sum(isbusy)<1
    time_flag=arrival_sorted(arrival_flag); %Ŀǰ��ʱ���
    [arrival_served2,queue,length_queue,time_avlb,isbusy]=event_arrival(arrival_served2,structure_this,queue,length_queue,time_avlb,isbusy,arrival_flag);
    arrival_flag=arrival_flag+1;
%����֮�������ѭ��
else
    [time_early_served,staff_early_served_index]=min(time_avlb(isbusy));
    temp=find(isbusy);
    staff_early_served=temp(staff_early_served_index);
    
    if time_early_served<arrival_sorted(arrival_flag)
        [arrival_served2,queue,length_queue,time_avlb,isbusy]=event_departure(arrival_served2,structure_this,queue,length_queue,time_avlb,isbusy,staff_early_served);
        time_flag=time_early_served;
    else
        time_flag=arrival_sorted(arrival_flag);
        [arrival_served2,queue,length_queue,time_avlb,isbusy]=event_arrival(arrival_served2,structure_this,queue,length_queue,time_avlb,isbusy,arrival_flag);
        arrival_flag=arrival_flag+1;
    end
end
end
arrival_served_record{rflag,sflag}=arrival_served2;
wait(rflag,sflag)=mean(arrival_served2(Nwarm:N+Nwarm,2));
end
end
filen=['d2_',int2str(cva(iiii)),int2str(cvs(jjjj)),int2str(us(kkkk))];
save(filen);
        end
    end
end