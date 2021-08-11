clc;
clear;
load other5;

t=50;
A_IFRall=zeros(t,num_strut);
APLall=@(WS,structure,n)norm(1-WS^n*structure,2);

for i=1:t

WS1_1=transtows_resource_so(structure5_1);
A_IFRall(i,1)=APLall(WS1_1,structure5_1,i);

WS1_2=transtows_resource_so(structure5_2);
A_IFRall(i,2)=APLall(WS1_2,structure5_2,i);

WS1_3=transtows_resource_so(structure5_3);
A_IFRall(i,3)=APLall(WS1_3,structure5_3,i);

WS1_4=transtows_resource_so(structure5_4);
A_IFRall(i,4)=APLall(WS1_4,structure5_4,i);

WS1_5=transtows_resource_so(structure5_5);
A_IFRall(i,5)=APLall(WS1_5,structure5_5,i);

WS1_6=transtows_resource_so(structure5_6);
A_IFRall(i,6)=APLall(WS1_6,structure5_6,i);

WS1_7=transtows_resource_so(structure5_7);
A_IFRall(i,7)=APLall(WS1_7,structure5_7,i);

WS1_8=transtows_resource_so(structure5_8);
A_IFRall(i,8)=APLall(WS1_8,structure5_8,i);

WS1_9=transtows_resource_so(structure5_9);
A_IFRall(i,9)=APLall(WS1_9,structure5_9,i);
end