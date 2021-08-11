clc
clear

D=[320,150,270,110,220,110,120,80,140,160,60,35,40,35,30,180];
C=[380,230,250,230,240,230,230,240];
arc2=[1,2,3,4,5,5,6,7,8,9,9,10,11,12,13,14,15,16];
arc1=[1,1,2,3,3,4,4,5,5,5,6,6,7,7,7,8,8,8];
s0=sparse(arc1',arc2',ones(length(arc1),1));

R=Rf(s0,1);
fg=norm(1-R,2);

gap=(1-R).^2;
demand=sum(gap).*D;
capacity=sum(gap,2).*C';

[~,which_d]=max(demand);
[~,which_c]=max(capacity);