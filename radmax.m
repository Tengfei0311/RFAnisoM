%Radial energy maximization with cosine moveout correction
function ircos=radmax(para,r,theta,phi,deltat)


time=para.time;
psint=para.psint;
%judge the input theta is rad system or angle system
if max(theta)>2*pi
theta=theta/180*pi;
end

for j=1:length(theta)
            rj(:,j)=interp1(time,r(:,j),time-deltat/2*cos(2*(phi-theta(j))),'linear');
end 
            rj(isnan(rj))=0;
        

    
        numer=(sum(rj,2)).^2;
        denom=(sum(r,2)).^2;
        

ircos=(max(numer(psint)))/(max(denom(psint)));

end

















