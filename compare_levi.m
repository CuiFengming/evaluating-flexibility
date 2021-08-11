clc;
clear;

load index_levi;
load compare_structure_levi;

p1=mean(corr(index_levi',makespan_my_short','type','pearson'),2);
p2=mean(corr(index_levi',makespan_my_short','type','spearman'),2);
p=[p1,p2];