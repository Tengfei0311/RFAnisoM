%Transverse energy minimization
function it=tranmin(para,r,t,theta,phi,deltat)

%judge the input theta is rad system or angle system
if max(theta)>2*pi
theta=theta/180*pi;
end
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
