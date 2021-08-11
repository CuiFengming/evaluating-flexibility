function index=APL3(WS)

num=size(WS,1);
total_capicity=sum(WS,1);
matrix_minus=WS-total_capicity/num;
index=sum(sum((matrix_minus).^2));

% index=sum(std(WS,1)./mean(WS,1));

% temp=1./distances(digraph(WS));
% index=sum(sum(triu(temp,1)))*2/(length(WS)*(length(WS)-1));

% index=sum(std(WS,0,2))+sum(std(WS,0,1));

% Mahalanobis Distance
% index=sum(pdist(WS','mahalanobis'));

% Euclidean Distance
% index=sum(pdist(WS','euclidean'));

% Jiajiao Distance
% index=sum(abs(1-pdist(WS,'cosine')));

% Mahalanobis Distance
% index=sum((pdist(WS,'correlation')));
end