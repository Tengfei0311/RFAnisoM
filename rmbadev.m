
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%   This script is used to remove events of which epicentral distance %%%
%%%  is not standard.                                                   %%%
%%%    You may have to change:1.datadir                                 %%%
%%%                           2.stalist                                 %%%
%%%                           3.eventdir                                %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



close all;
clear all;

%%%%%the directory contains data seperated by stations
datadir='/home/Nino/tbc/NCC_Aniso/';
cd(datadir);
stalist=dir('TZ*');%%%%%read stations by directory sign

for k=1:length(stalist)
    statemp=char(stalist(k).name);
    stadir=fullfile(datadir,statemp);
    cd(stadir);
    eventdir=dir('Event*');%%%%%event directory sign
    
    for i=1:length(eventdir)
        cd(eventdir(i).name);
        eqrname=strcat(statemp,'_2.5.i.eqr');
        eqtname=strcat(statemp,'_2.5.i.eqt');
        headtempeqr=readsac(eqrname);
        headtempeqt=readsac(eqtname);
        [timer(:,i),eqr(:,i)]=getsacdata(headtempeqr);
        [timet(:,i),eqt(:,i)]=getsacdata(headtempeqt);
        gcarc(i)=headtempeqr.GCARC;
        cd ..;
    end
    
    badevno=find((gcarc<30 | gcarc>90)~=0);
    badevls={};
    for i=1:length(badevno)
        badevls{i}=eventdir(badevno(i)).name;
        cmd=['rm -r ',stadir,'/',badevls{i}];
        system(cmd);
    end
    
  %  for i=1:size(eqr,2)
  %      if isnan(eqr(1,i)) || isnan(eqt(1,i))
  %          cmd=['rm -r ',stadir,'/',eventdir(i).name];
  %          system(cmd);
  %      end
  %  end
    disp(statemp);
    
    clear badevls;
    clear badevno;
    clear eqr;
    clear eqt;
    clear eventdir;
    clear gcarc;
    clear headtempeqr;
    clear headtempeqt;
    clear timer;
    clear timet;
    
end

        
        

