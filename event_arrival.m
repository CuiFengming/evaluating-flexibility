function [arrival_served_new,queue_new,length_queue_new,time_avlb_new,isbusy_new]=event_arrival(arrival_served,structure,queue,length_queue,time_avlb,isbusy,arrival_flag)
%输出参数的初始化
arrival_served_new=arrival_served;
queue_new=queue;
length_queue_new=length_queue;
time_avlb_new=time_avlb;
isbusy_new=isbusy;

which_demand=arrival_served(arrival_flag,5);
time_flag=arrival_served(arrival_flag,1);

assign_matrix=full(structure);

if length_queue(which_demand)>0
    length_queue_new(which_demand)=length_queue_new(which_demand)+1;
    queue_new{which_demand}=[queue_new{which_demand},arrival_flag];
else
    %既可以做这个工作，同时又空闲的员工
    which_staff_can_do=find((assign_matrix(:,which_demand)==1).*(~isbusy));
    if isempty(which_staff_can_do)
        length_queue_new(which_demand)=length_queue_new(which_demand)+1;
        queue_new{which_demand}=[queue_new{which_demand},arrival_flag];
    else
        [~,which_staff]=min(time_avlb(which_staff_can_do));%多个员工空闲时，找等待时间最长的员工来服务
        staff_chosen=which_staff_can_do(which_staff);
        time_avlb_new(staff_chosen)=arrival_served(arrival_flag,1)+arrival_served(arrival_flag,3);
        arrival_served_new(arrival_flag,2)=0;
        arrival_served_new(arrival_flag,4)=time_avlb_new(staff_chosen);
        arrival_served_new(arrival_flag,6)=staff_chosen;
        isbusy_new(staff_chosen)=1;
    end
end
    
end