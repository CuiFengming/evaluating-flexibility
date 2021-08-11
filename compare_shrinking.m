clc;
clear;

load allshrinking;
rho=zeros(1,4);
rho1=rho;
rho(1)=corr(allshrinking(end,:)',allshrinking(1,:)','type','pearson');
rho(2)=corr(allshrinking(end,:)',allshrinking(2,:)','type','pearson');
rho(3)=corr(allshrinking(end,:)',allshrinking(3,:)','type','pearson');
rho(4)=corr(allshrinking(end,:)',allshrinking(4,:)','type','pearson');

rho1(1)=corr(allshrinking(end,:)',allshrinking(1,:)','type','spearman');
rho1(2)=corr(allshrinking(end,:)',allshrinking(2,:)','type','spearman');
rho1(3)=corr(allshrinking(end,:)',allshrinking(3,:)','type','spearman');
rho1(4)=corr(allshrinking(end,:)',allshrinking(4,:)','type','spearman');

rhoU(1)=corr(allshrinking(end-1,:)',allshrinking(1,:)','type','pearson');
rhoU(2)=corr(allshrinking(end-1,:)',allshrinking(2,:)','type','pearson');
rhoU(3)=corr(allshrinking(end-1,:)',allshrinking(3,:)','type','pearson');
rhoU(4)=corr(allshrinking(end-1,:)',allshrinking(4,:)','type','pearson');

rho1U(1)=corr(allshrinking(end-1,:)',allshrinking(1,:)','type','spearman');
rho1U(2)=corr(allshrinking(end-1,:)',allshrinking(2,:)','type','spearman');
rho1U(3)=corr(allshrinking(end-1,:)',allshrinking(3,:)','type','spearman');
rho1U(4)=corr(allshrinking(end-1,:)',allshrinking(4,:)','type','spearman');