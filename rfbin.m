function [rfrb,rftb,bazbin]=rfbin(rfr,rft,baz)
%%bin rf in each 5 degree
num=360/5;
flag=0;
for i=1:num
    if i==1
        bazindex=(baz<=5)&(baz>=355);
        rfcount(i)=sum(bazindex);
    else
        bazindex=(baz<=(5*i))&(baz>=(5*i-5));
    rfcount(i)=sum(bazindex);
    end
    if rfcount(i)~=0
        flag=flag+1;
     bazbin(flag)=(i-1)*5;
    
     
    rfrb(:,flag)=sum(rfr(:,bazindex),2)/rfcount(i);
    rftb(:,flag)=sum(rft(:,bazindex),2)/rfcount(i);
    end
end
end

