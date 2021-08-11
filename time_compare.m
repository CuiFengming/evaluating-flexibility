clc;
clear;

n=[50,100,150,200,250,300];
timeval=zeros(6,4);
for i=1:6

s=chainnet(3*ones(n(i),1),3*ones(n(i),1));


tic;
sf=sffunc(s);
timeval(i,1)=toc;

tic;
APL1=@(WS)sum(sum(triu(distances(graph(WS)),1)))*2/(length(WS)*(length(WS)-1));%平均最短路径
ws=APL1(transtows(s));
timeval(i,2)=toc;

tic;
fg=norm(1-transtows_resource_so(s)*s,2);
timeval(i,3)=toc;

tic;
expansion=expfunc(s);
timeval(i,4)=toc;
end