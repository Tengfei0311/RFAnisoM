%Transverse energy minimization
function it=tranmin(para,r,t,theta,phi,deltat)


time=para.time;
psint=para.psint;

%calculate corrected r,t component
[rc,tc]=correctanis(para,r,t,theta,phi,deltat);

for j=1:length(theta)
    numor(j)=trapz(time(psint),(tc(psint,j)).^2);%%%%%%%%%%%%%
    denom(j)=trapz(time(psint),(t(psint,j)).^2);%%%%%%%%%%%%%%%%%%
end
it=(sum(numor))/(sum(denom));

end