%Function to generate the time differnce tau for all the slave sensors.
function td= TimeDifference(r0,xt,yt,S,v)

%calculating 'r' distance of emitter from slave sensor 
r = sqrt((xt-S(1)).^2+(yt-S(2)).^2); 

n=length(xt);
rd=r0-r;
% To add noise to the TDOA measurements, given mean and standard deviation
% For noiseless measurements make the standard deviation as 0 in the
% normrnd
td= (rd/v)+(rd/v).*normrnd(0,1,[1,n])*0;
end

    