function moveouttime=moveout(evdelta,evdepth,stddelta,stddepth,moho)

%calculate ray parameter 
commandev=['taup_time -mod ak135 -ph P -deg ',num2str(evdelta),' -h ',num2str(evdepth),' --rayp'];
[status,evp]=system(commandev);
evp=str2double(evp);
evp=evp*360/2/pi/6371;
commandstd=['taup_time -mod ak135 -ph P -deg ',num2str(stddelta),' -h ',num2str(stddepth),' --rayp'];
[status,stdp]=system(commandstd);
stdp=str2double(stdp);
stdp=stdp*360/2/pi/6371;

%calculate ak135 model
if nargin<5
moho=40;
end

evtime=(moho-35)*(sqrt(4.48.^-2-evp.^2)-sqrt(8.04.^-2-evp.^2))+15*(sqrt(3.85.^-2-evp.^2)-sqrt(6.5.^-2-evp.^2))+20*(sqrt(3.46.^-2-evp.^2)-sqrt(5.8.^-2-evp.^2));
stdtime=(moho-35)*(sqrt(4.48.^-2-stdp.^2)-sqrt(8.04.^-2-stdp.^2))+15*(sqrt(3.85.^-2-stdp.^2)-sqrt(6.5.^-2-stdp.^2))+20*(sqrt(3.46.^-2-stdp.^2)-sqrt(5.8.^-2-stdp.^2));
moveouttime=evtime-stdtime;
end

