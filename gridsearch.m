%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%    You may have to change:1.datadir                                 %%%
%%%                           2.stalist                                 %%%
%%%                           3.eventdir                                %%%
%%%                           4.search range of phi & deltat            %%%
%%%                           5.para.rate para.time para.psint          %%%   
%%%                      *****6.para.pstime                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;


datadir='/home/Nino/tbc/NCC_Aniso/';
cd(datadir);
stalist=dir('TZ*');%%%%%

%search range of phi
phib=0;
phie=2*pi;
phiint=pi/180;
phi=phib:phiint:phie;

%search range of deltat
deltatb=0;
deltate=1.5;
deltatint=0.01;
deltat=deltatb:deltatint:deltate;

%%%%time series before and after P arrival
para.timeb=-10;
para.timee=100;
para.rate=0.1;
para.time=para.timeb:para.rate:para.timee;


%%%THIS IS DETERMINED BY REAL DATA!
para.pstime=0;


para.psint=round(((para.pstime-2-para.timeb)/para.rate):((para.pstime+2-para.timeb)/para.rate));%%%%%Ps range,to be changed

for k=1:length(stalist)

  staindex=char(stalist(k).name);
    stadir=fullfile(datadir,staindex);
    cd(stadir);
    eventdir=dir('Event*');
    
    
for i=1:length(eventdir)
    cd(eventdir(i).name);
    eqrname=strcat(staindex,'_2.5.i.eqr');
    eqtname=strcat(staindex,'_2.5.i.eqt');
    headtempeqr=readsac(eqrname);
    headtempeqt=readsac(eqtname);
    [timer(:,i),eqr(:,i)]=getsacdata(headtempeqr);
    [timet(:,i),eqt(:,i)]=getsacdata(headtempeqt);
    
    evdp(i)=headtempeqr.EVDP;
   
    gcarc(i)=headtempeqr.GCARC;
    %az(i)=headtempeqr.AZ;
    baz(i)=headtempeqr.BAZ;
    moveouttime(i)=moveout(gcarc(i),evdp(i),67,0);
    
    
    cd ..
    
end




r=eqr;%%%you can choose an interval of eqr & eqt, for example,[-5,15]s P arrival
t=eqt;



%moveout correct
for i=1:length(moveouttime)
rmc(:,i)=interp1(para.time,r(:,i),para.time-moveouttime(i),'linear');
tmc(:,i)=interp1(para.time,t(:,i),para.time-moveouttime(i),'linear');
end
rmc(isnan(rmc))=0;
tmc(isnan(tmc))=0;

%normalize r & t
rnorm=rfnormal(rmc,baz);
tnorm=rfnormal(tmc,baz);




%%if use matlab parallel   
%%parfor i=1:length(phi)
    for i=1:length(phi)    
    for j=1:length(deltat)
        radmaxsearch(i,j)=radmax(para,rnorm,baz,phi(i),deltat(j));
        radccmaxsearch(i,j)=radccmax(para,rnorm,tnorm,baz,phi(i),deltat(j));
        tranminsearch(i,j)=tranmin(para,rnorm,tnorm,baz,phi(i),deltat(j));
    end
    end



jointmaxsearch=radmaxsearch.*radccmaxsearch./tranminsearch;
staname=[stalist(k).name(4:7),'search'];
save(staname,'radmaxsearch','radccmaxsearch','tranminsearch','jointmaxsearch');
disp(stalist(k).name);

clear radmaxsearch radccmaxsearch tranminsearch jointmaxsearch staname;
clear baz eqr eqrname eqt eqtname evdp eventdir gcarc headtempeqr headtempeqt moveouttime para r rmc rnorm t timer timet tmc tnorm;
end





