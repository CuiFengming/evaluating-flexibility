function num_path_weighted=matrix_power(matrix_flow,ns,nd,i,j)
num_path_weighted=zeros(ns+nd-1,1);
for nn=2:2:(ns+nd-1)
    matrix_flow_power=matrix_flow^nn;
    num_path_weighted(nn)=(ns+1-nn/2)/ns*matrix_flow_power(i,j);
end
end