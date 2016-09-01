function rfnorm=rfnormal(rf,baz)
%
num=length(baz);
for i=1:num
    bazmin=baz(i)-10;
    bazmax=baz(i)+10;
    binbaz=(baz>bazmin & baz<bazmax);
    factor(i)=sum(binbaz~=0);
end
for i=1:num
    rfnorm(:,i)=rf(:,i)./factor(i);
end
end

