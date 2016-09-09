%single_event based method 

function [rc,tc]=correctanis(para,r,t,theta,phi,deltat)

%judge the input theta is rad system or angle system
if max(theta)>2*pi
theta=theta/180*pi;
end


num=length(para.time);
eventnum=length(theta);

%step1:projecting each receiver function pair [r(t) and t(t)] to the assumed fast 
%and slow polarization directions f(t,phi) and s(t,phi) 
for j=1:eventnum
for i=1:num
    f(i,j)=r(i,j)*cos(phi-theta(j))+t(i,j)*sin(phi-theta(j));
    s(i,j)=-r(i,j)*sin(phi-theta(j))+t(i,j)*cos(phi-theta(j));
end
end

%step2:time shifting the fast component f(t,phi) forward and the slow component
%s(t,phi) backward by half of the assumed splitting time deltat to form the
%corrected fast and slow component fc(t,phi,deltat) and sc(t,phi,deltat)

fc=interp1(para.time,f,para.time-deltat/2,'linear');
sc=interp1(para.time,s,para.time+deltat/2,'linear');
          
fc(isnan(fc))=0;
sc(isnan(sc))=0;

%step3:project the time-corrected receiver-functon pair fc(phi,deltat,t)
%and sc(phi,deltat,t) badk to the R and T directions rc(phi,deltat,t) and
%tc(phi,deltat,t)
for j=1:eventnum
for i=1:num
   rc(i,j)=fc(i,j)*cos(phi-theta(j))-sc(i,j)*sin(phi-theta(j));
   tc(i,j)=fc(i,j)*sin(phi-theta(j))+sc(i,j)*cos(phi-theta(j));
end
end

end
