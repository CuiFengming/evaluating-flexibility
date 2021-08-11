clc;
clear;

% case 5 ************************************************
D5=[1,1,1,1,1,1,1,1];
num_strut=9;

arc5_1=[[1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8]',[1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,1]'];
structure5_1=sparse(arc5_1(:,1),arc5_1(:,2),ones(length(arc5_1),1));

arc5_2=[[1,1,2,2,3,3,4,4,4,4,5,5,5,5,6,6,7,7,8,8]',[1,2,1,3,2,4,3,4,5,6,3,4,5,6,5,7,6,8,7,8]'];
structure5_2=sparse(arc5_2(:,1),arc5_2(:,2),ones(length(arc5_2),1));

arc5_3=[[1,1,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,8,8]',[1,2,1,3,3,4,5,6,3,4,5,6,4,5,6,7,4,5,6,7,7,8,2,8]'];
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

% %*****************************************************
% APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));
% APL_index1=zeros(1,num_strut);
% 
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
% %*********************************
% APL2=@(WS)mean(mean(distances(digraph(WS))));
% APL_index2=zeros(1,num_strut);
% 
% WS2_1=transtows_resource(structure5_1);
% APL_index2(1)=APL2(WS2_1);
% 
% WS2_2=transtows_resource(structure5_2);
% APL_index2(2)=APL2(WS2_2);
% 
% WS2_3=transtows_resource(structure5_3);  
% APL_index2(3)=APL2(WS2_3);
% 
% WS2_4=transtows_resource(structure5_4);
% APL_index2(4)=APL2(WS2_4);
% 
% WS2_5=transtows_resource(structure5_5);
% APL_index2(5)=APL2(WS2_5);
% 
% WS2_6=transtows_resource(structure5_6);
% APL_index2(6)=APL2(WS2_6);
% 
% WS2_7=transtows_resource(structure5_7);
% APL_index2(7)=APL2(WS2_7);
% 
% WS2_8=transtows_resource(structure5_8);
% APL_index2(8)=APL2(WS2_8);
% 
% WS2_9=transtows_resource(structure5_9);
% APL_index2(9)=APL2(WS2_9);
% 
% [a,b]=sort(APL_index1);
% [c,d]=sort(APL_index2);
% [b;d]

%———————————————————————————————————————
% CV=1 **************************************************
total_time=5000;

%总服务个数
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
arrival=zeros(size(D5,2),upperbound_arrival);

%arrival cv=1;serve cv=1;server u=0.9;
cv_arrival=cva(iiii);
cv_serve=cvs(jjjj);
u_serve=0.7;

alpha_arrival=1/(cv_arrival^2);
alpha_serve=1/(cv_serve^2);
beta_serve=u_serve*(cv_serve^2);

num_demand=max(arc5_1(:,2));
num_staff=max(arc5_1(:,1));

%重复试验开始______________________________________________________________
num_repeat=30;
wait=zeros(num_repeat,num_strut);
arrival_served_record=cell(num_repeat,num_strut);

for rflag=1:num_repeat
for i=1:num_demand
    arrival(i,:)=gamrnd(alpha_arrival,1/D5(i)/alpha_arrival,1,upperbound_arrival);
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
arrival_served=arrival_served(1:upperbound_arrival+Nwarm,:);
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
    structure_this=eval(['structure5_',num2str(sflag)]);
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
filen=['d5_',int2str(cva(iiii)),int2str(cvs(jjjj)),int2str(us(kkkk))];
save(filen);
        end
    end
end