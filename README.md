# RFAnisoM
written by Yang Yan,USTC,2016/06:yy951016@mail.ustc.edu.cn

This is a Brief Manual  

This package containing some short matlab scripts is used to estimate crustal azimuthal anisotropy from receiver functions.

Before you run the MATLAB scripts you have to install some neccesary softwares on your operator system including MATLAB ,SAC and Taup."http://seisman.info/" may help.

Note that there are some matlab scripts to read and write ".SAC" data in matlab, you can find them in your .../sac/utils directory,for example: /usr/local/sac/utils. This package will use readsac.m and getsacdata.m. Make sure that they have been added to your matlab path.

This package is used when you have generated the receiver functions. A great tool to preview your RF waveform is funclab. Please Google 'funclab' to read its manual. Since my scripts is based on the pre-funclab format data, you should pay attention to some format parameters if your data is not the same format as mine.

This package includes 3 main Matlab scripts,which can be explained as the following:

Step 1: extractdata.m
Usually the seismic data are divided by events. This script is used to divide data by stations.

Step 2:rmbadev.m
Ensure epicentral distances between 30 and 90 so that the ray parameter computed by taup is unique.

Step 3:gridsearch.m
Compute move-out, normalize the RFs(or stack RFs in backazimuth) and grid search for the best pair of anisotropy parameters.

There are several parameters to change according to yourself.Read the notes of each script to see what to change.

!!!It's important to confirm the para.***:
para.pstime:observe the RF wave and assign a proper Ps arrival time, you can take previous results into account. For example, Moho depth 40km, para.pstime=5.0s.
para.timeb & para.timee: depends on the RF data's time range you need. For example, [-5,25]s.
para.psint:depends on you Ps wave's width. For example,0.5s before and after Ps arrival time.



Add the package into your MATLAB path if some function needed is not found.

Sadly, there may be some other bugs to be found...
