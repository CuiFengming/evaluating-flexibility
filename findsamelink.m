clc;
clear;
% load levi;
% load chain_revised;
load samedegree1;
N=130;
% chain3=chainnet(3*ones(27,1),3*ones(27,1));
% net2=rewritingnet(3*ones(27,1),3*ones(27,1),0.02);
% net3=rewritingnet(3*ones(27,1),3*ones(27,1),0.1);
% net4=rewritingnet(3*ones(27,1),3*ones(27,1),0.5);
fg1=ones(1,N+1); %levi graph
fg2=fg1;       %rand graph
fg3=fg1;       %rewriting graph
fg4=fg1;       %3-chain graph
fg5=fg1;       %chain_revised1
fg6=fg1;       %chain_revised2

for i=0:N
    fg1(i+1)=norm(3/27-transtows_resource_so(Levi)^i*Levi,2);
    fg2(i+1)=norm(3/27-transtows_resource_so(net4)^i*net4,2);
    fg3(i+1)=norm(3/27-transtows_resource_so(net3)^i*net3,2);
    fg4(i+1)=norm(3/27-transtows_resource_so(net2)^i*net2,2);
    fg5(i+1)=norm(3/27-transtows_resource_so(chain3)^i*chain3,2);
%     fg6(i+1)=norm(3/27-transtows_resource_so(chain3_27)^i*chain3_27,2);
    
end

plot1=plot(0:N,[fg1;fg2;fg3;fg4;fg5]);
set(plot1(1),'DisplayName','Levi graph');
set(plot1(2),'DisplayName','3-chain p=0.5');
set(plot1(3),'DisplayName','3-chain p=0.1');
set(plot1(4),'DisplayName','3-chain p=0.02');
set(plot1(5),'DisplayName','3-chain');

N=3000;
es=zeros(5,N);
esn=es;
for i=1:N
    D=2*ones(1,27);
    C=D;
    D_rand=2*D.*rand(1,length(D));
    es(1,i)=findshort(Levi,D_rand,C);
    es(2,i)=findshort(net4,D_rand,C);
    es(3,i)=findshort(net3,D_rand,C);
    es(4,i)=findshort(net2,D_rand,C);
    es(5,i)=findshort(chain3,D_rand,C);
    
    D_norm=2*D.*tracnorm(length(D),0.5,1.2,0,1);
    esn(1,i)=findshort(Levi,D_norm,C);
    esn(2,i)=findshort(net4,D_norm,C);
    esn(3,i)=findshort(net3,D_norm,C);
    esn(4,i)=findshort(net2,D_norm,C);
    esn(5,i)=findshort(chain3,D_norm,C);
end
ese=mean(es,2);
esene=mean(esn,2);
