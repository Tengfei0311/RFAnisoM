function [rfb,bazbin]=rfbin(rf,baz)
%%bin rf in each 5 degree
num=360/5;
flag=0;
for i=1:num
    rfcount(i)=sum((baz<=(5*i))&(baz>=5*(i-1)));
    if rfcount(i)~=0
        flag=flag+1;
     bazbin(flag)=i*5/2;
        
    rfb(:,flag)=sum(rf(:,(baz<=(5*i))&(baz>=5*(i-1))),2)/rfcount(i);
    end
end
end
