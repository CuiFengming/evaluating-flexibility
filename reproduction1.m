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

% %*****************************************************
% APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));
% APL_index1=zeros(1,num_strut);
% 
% WS1_1=transtows(structure1_1);
% APL_index1(1)=APL1(WS1_1);
% 
% WS1_2=transtows(structure1_2);
% APL_index1(2)=APL1(WS1_2);
% 
% WS1_3=transtows(structure1_3);
% APL_index1(3)=APL1(WS1_3);
% 
% WS1_4=transtows(structure1_4);
% APL_index1(4)=APL1(WS1_4);
% %*********************************
% APL2=@(WS)mean(mean(distances(digraph(WS))));
% APL_index2=zeros(1,num_strut);
% 
% 
% WS2_1=transtows_resource(structure1_1);
% APL_index2(1)=APL2(WS2_1);
% 
% WS2_2=transtows_resource(structure1_2);
% APL_index2(2)=APL2(WS2_2);
% 
% WS2_3=transtows_resource(structure1_3);
% APL_index2(3)=APL2(WS2_3);
% 
% WS2_4=transtows_resource(structure1_4);
% APL_index2(4)=APL2(WS2_4);
% 
% [~,b]=sort(APL_index1);
% [~,d]=sort(APL_index2);
% [b;d]

%———————————————————————————————————————
% CV=1 **************************************************
% total_time=5000;

%总服务个数
% N=50000; 
% cva=[1,2];
cva=[1,2];
cvs=[1,2];
% us=[7,9];
us=[7];

for iiii=1:2
    for jjjj=1:2
        for kkkk=1:1

% upperbound_arrival=total_time*max(D1)*1.5;
upperbound_arrival=23000;
N=20000;
Nwarm=1500;
arrival=zeros(length(D1),upperbound_arrival);

%arrival cv=1;serve cv=1;server u=0.9;
cv_arrival=cva(iiii);
cv_serve=cvs(jjjj);
u_serve=0.7;

alpha_arrival=1/(cv_arrival^2);
alpha_serve=1/(cv_serve^2);
beta_serve=u_serve*(cv_serve^2);


num_demand=max(arc1_1(:,2));
num_staff=max(arc1_1(:,1));

%重复试验开始______________________________________________________________
num_repeat=30;
wait=zeros(num_repeat,num_strut);
arrival_served_record=cell(num_repeat,num_strut);

for rflag=1:num_repeat
for i=1:num_demand
    arrival(i,:)=gamrnd(alpha_arrival,1/D1(i)/alpha_arrival,1,upperbound_arrival);
    arrival(i,:)=cumsum(arrival(i,:));
end

%把所有种类的到达合并在一起，当做一条输入流
arrival_total=arrival(1,:);
arrival_index=ones(1,upperbound_arrival);
for i=2:num_demand
    arrival_total=[arrival_total,arrival(i,:)];
    arrival_index=[arrival_index,ones(1,upperbound_arrival)*i];
end
[arrival_sorted,index_sorted]=sort(arrival_total);
arrival_index_sorted=arrival_index(index_sorted);

arrival_served=zeros(length(arrival_sorted),6);%1到达时间点；2等待时间段；3服务时间段；4离开时间点；5需求到达编号；6服务员工编号
arrival_served(:,1)=arrival_sorted';
arrival_served(:,5)=arrival_index_sorted';
arrival_served(:,3)=gamrnd(alpha_serve,beta_serve,1,length(arrival_sorted));%服务时间是多少
arrival_served=arrival_served(1:upperbound_arrival,:);
%开始每一个结构的仿真计算，算出等待时间_______________________________

for sflag=1:num_strut
arrival_served2=arrival_served;
arrival_flag=1;
time_flag=0;
%定义每个需求的排队队列，第一个是数组，表示队列。第二个是排队人数
queue=cell(1,num_demand);
for i=1:num_demand
    queue{i}=[];
end
length_queue=zeros(num_demand,1);

%定义每个员工目前的状态
isbusy=false(num_staff,1);
time_avlb=zeros(num_staff,1);

while(sum(arrival_served2(:,end)>0)<=N+Nwarm) %arrival_flag是目前到达的第x个
    structure_this=eval(['structure1_',num2str(sflag)]);
%初始状态，如果所有的服务者都空闲，则到达进入系统。
if sum(isbusy)<1
    time_flag=arrival_sorted(arrival_flag); %目前的时间点
    [arrival_served2,queue,length_queue,time_avlb,isbusy]=event_arrival(arrival_served2,structure_this,queue,length_queue,time_avlb,isbusy,arrival_flag);
    arrival_flag=arrival_flag+1;
%进入之后的正常循环
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
filen=['d1_',int2str(cva(iiii)),int2str(cvs(jjjj)),int2str(us(kkkk))];
save(filen);
        end
    end
end