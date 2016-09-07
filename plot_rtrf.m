function plot_rtrf(r,t,time,baz,bin,scale)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot radial and transverse RFs by backazimuth in the same amplitude in one graph
%
% Written by Yang Yan @ USTC, September 7th, 2016
%
% Input:
% r - radial RFs ,size(r)=[sample numbers,traces]
% t - transverse RFs ,size(t)=[sample numbers,traces]
% time  - time axes accordingly
% baz - backazimuth
% bin - 5 degree or others
% scale - scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





nx=360/bin;

flag=0;

for i=1:nx
    if i==1
        bazindex=(baz<=bin)&(baz>=360-bin);
        rfcount(i)=sum(bazindex);
    else

        bazindex=(baz<=(bin*i))&(baz>=(bin*(i-1)));
    rfcount(i)=sum(bazindex); 
    end
    if rfcount(i)~=0
        flag=flag+1;
     bazbin(flag)=(i-1)*bin;
    
     
    rb(:,flag)=sum(r(:,bazindex),2)/rfcount(i);
    tb(:,flag)=sum(t(:,bazindex),2)/rfcount(i);
    end
  
   
end
disp('plotting...');
figure;
subplot('Position',[0.03,0.05,0.45,0.9]);
plotimag_noedge(rb,scale,bazbin,time,1);
plotimag_gray(rb,scale,bazbin,time,1);
subplot('Position',[0.52,0.05,0.45,0.9]);
plotimag_noedge(tb,scale,bazbin,time,1);
plotimag_gray(tb,scale,bazbin,time,1);
end