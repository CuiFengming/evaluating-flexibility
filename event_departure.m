function [arrival_served_new,queue_new,length_queue_new,time_avlb_new,isbusy_new]=event_departure(arrival_served,structure,queue,length_queue,time_avlb,isbusy,staff_early_served)

arrival_served_new=arrival_served;
queue_new=queue;
length_queue_new=length_queue;
time_avlb_new=time_avlb;
isbusy_new=isbusy;

assign_matrix=full(structure);
now=time_avlb(staff_early_served);

isbusy_new(staff_early_served)=0;
demand_can_do=find(assign_matrix(staff_early_served,:));

[longest,~]=max(length_queue(demand_can_do));
which_longest=find(length_queue(demand_can_do)==longest);
which_demand=which_longest(randi(length(which_longest)));
demand_chosen=demand_can_do(which_demand);%找到队列时间最长的一个需求

if length_queue(demand_chosen)>0
    queue_this=queue{demand_chosen};
    arrival_chosen=queue_this(1);
    arrival_served_new(arrival_chosen,2)=now-arrival_served_new(arrival_chosen,1);
    arrival_served_new(arrival_chosen,4)=now+arrival_served_new(arrival_chosen,3);
    arrival_served_new(arrival_chosen,6)=staff_early_served;
    
    isbusy_new(staff_early_served)=1;
    time_avlb_new(staff_early_served)=arrival_served_new(arrival_chosen,4);
    
    length_queue_new(demand_chosen)=length_queue_new(demand_chosen)-1;
    if length_queue_new(demand_chosen)==0
        queue_new{demand_chosen}=[];
    else
        queue_new{demand_chosen}=queue_this(2:end);
    end
end
end