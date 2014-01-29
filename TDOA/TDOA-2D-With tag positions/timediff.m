%************************************************************************
%Function to generate the time differnce tau for all the slave sensors.
%************************************************************************

function y= timediff(r0,xt,yt,Sl,v)
%function calculating distence vector 'r'  for each of the slave sensor
r = sqrt((xt-Sl(1)).^2+(yt-Sl(2)).^2); % get real distance from emitter for each and one of the stations
rd=r0-r;
y= rd/v;
end

    