%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  This script is used to divide data by stations instead of events.  %%%
%%%    You may have to change:1.datadir                                 %%%
%%%                           2.staindex                                %%%
%%%                           3.eventid                                 %%%
%%%                           4.newdir                                  %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


clear all;
close all;
%%%%%the directory contains all the event directories
datadir='/home/Nino/data/RAWDATA/';
cd(datadir);
%%%%%the txt which ONLY has station names
staindex=textread('/home/Nino/tbc/stationlist.txt','%s'); 
%%%%%prefunclab event directory has this format
eventid='Event_*';
events=dir(fullfile(datadir,eventid));

for i=1:length(staindex)
    %%%%%a directory to put the data you copy
    newdir{i}=strcat('/home/Nino/tbc/NCC_Aniso/TZ.',staindex{i});
    if ~exist(newdir{i});
        mkdir(newdir{i});
    end
    
    for j=1:length(events)
        eventdir=fullfile(datadir,events(j).name);
        eventdir_new=fullfile(newdir{i},events(j).name);
        eqr=fullfile(eventdir,strcat('TZ.',staindex{i},'_2.5.i.eqr'));
        eqt=fullfile(eventdir,strcat('TZ.',staindex{i},'_2.5.i.eqt'));
        eqz=fullfile(eventdir,strcat('TZ.',staindex{i},'_2.5.i.z'));
        if exist(eqr) && exist(eqt) && exist(eqz) 
            cmd1=['mkdir ',eventdir_new];
            [status,result]=system(cmd1);
            cmd2=['cp ',eqr,' ',eqt,' ',eqz,' ',eventdir_new];
            [status,result]=system(cmd2);
        end
        fprintf('Copy station %s from %s to %s successfully\n',char(staindex{i}),eventdir,eventdir_new);
    end
end
