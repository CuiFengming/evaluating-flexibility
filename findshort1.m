function [obj,x,result]=findshort1(structure,D,C)

structure=full(structure);
ns=size(structure,1);
nd=size(structure,2);
x=sdpvar(ns,nd);
g=sdpvar(1,nd);
obj=sum(g);
Contraint=[x>=0;g>=0];
for i=1:ns
    s=sum(x(i,:));
    Contraint=[Contraint;s<=C(i)];
end

for i=1:nd
    s=sum(x(:,i))+g(i);
    Contraint=[Contraint;s>=D(i)];
end

for i=1:ns
    for j=1:nd
        Contraint=[Contraint;x(i,j)<=structure(i,j)];
    end
end

ops=sdpsettings('solver','cplex');
result=solvesdp(Contraint,obj);
x=double(x);
obj=double(obj);
end