function [fg,fgfull,fglink,fgconnect0,fgconnect1,fg_pro]=fgf(structure)
% [pstar,M]=pstarf(structure);
M=transtows_resource_so(structure);
pstar=plimf(structure);

fglink=norm(1-pstar,2);
fgconnect0=norm(pstar-M^0*structure,2);
fgconnect1=norm(pstar-M^1*structure,2);
fg=norm(1-M^1*structure,2);
fgfull=fglink+fgconnect0;
fg_pro=fglink*(1+norm(M*structure-pstar,2)/norm(pstar-structure,2));

end