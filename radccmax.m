
    
%Radial correlation coefficient (cc) maximization
function ircc=radccmax(para,r,t,theta,phi,deltat)

%judge the input theta is rad system or angle system
if max(theta)>2*pi
theta=theta/180*pi;
end
time=para.time;
psint=para.psint;

%calculate corrected r,t component
[rc,tc]=correctanis(para,r,t,theta,phi,deltat);

    numor=(sum(rc,2)).^2-sum(rc.^2,2);
    denom=(sum(r,2)).^2-sum(r.^2,2);
    
   
    
ircc=(trapz(time(psint),numor(psint)))/(trapz(time(psint),denom(psint)));

end
