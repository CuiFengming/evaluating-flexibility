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

%！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
% CV=1 **************************************************
% total_time=5000;

%悳捲暦倖方
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

%嶷鹸編刮蝕兵______________________________________________________________
num_repeat=30;
wait=zeros(num_repeat,num_strut);
arrival_served_record=cell(num_repeat,num_strut);

for rflag=1:num_repeat
for i=1:num_demand
    arrival(i,:)=gamrnd(alpha_arrival,1/D1(i)/alpha_arrival,1,upperbound_arrival);
    arrival(i,:)=cumsum(arrival(i,:));
end

%委侭嗤嶽窃議欺器栽旺壓匯軟??輝恂匯訳補秘送
arrival_total=arrival(1,:);
arrival_index=ones(1,upperbound_arrival);
for i=2:num_demand
    arrival_total=[arrival_total,arrival(i,:)];
    arrival_index=[arrival_index,ones(1,upperbound_arrival)*i];
end
[arrival_sorted,index_sorted]=sort(arrival_total);
arrival_index_sorted=arrival_index(index_sorted);

arrival_served=zeros(length(arrival_sorted),6);%1欺器扮寂泣??2吉棋扮寂粁??3捲暦扮寂粁??4宣蝕扮寂泣??5俶箔欺器園催??6捲暦埀垢園催
arrival_served(:,1)=arrival_sorted';
arrival_served(:,5)=arrival_index_sorted';
arrival_served(:,3)=gamrnd(alpha_serve,beta_serve,1,length(arrival_sorted));%捲暦扮寂頁謹富
arrival_served=arrival_served(1:upperbound_arrival,:);
%蝕兵耽匯倖潤更議径寔柴麻??麻竃吉棋扮寂_______________________________

for sflag=1:num_strut
arrival_served2=arrival_served;
arrival_flag=1;
time_flag=0;
%協吶耽倖俶箔議電錦錦双??及匯倖頁方怏??燕幣錦双。及屈倖頁電錦繁方
queue=cell(1,num_demand);
for i=1:num_demand
    queue{i}=[];
end
length_queue=zeros(num_demand,1);

%協吶耽倖埀垢朕念議彜蓑
isbusy=false(num_staff,1);
time_avlb=zeros(num_staff,1);

while(sum(arrival_served2(:,end)>0)<=N+Nwarm) %arrival_flag頁朕念欺器議及x倖
    structure_this=eval(['structure1_',num2str(sflag)]);
%兜兵彜蓑??泌惚侭嗤議捲暦宀脅腎椀??夸欺器序秘狼由。
if sum(isbusy)<1
    time_flag=arrival_sorted(arrival_flag); %朕念議扮寂泣
    [arrival_served2,queue,length_queue,time_avlb,isbusy]=event_arrival(arrival_served2,structure_this,queue,length_queue,time_avlb,isbusy,arrival_flag);
    arrival_flag=arrival_flag+1;
%序秘岻朔議屎械儉桟
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