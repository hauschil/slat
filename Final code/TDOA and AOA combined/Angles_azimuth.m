%% Function to generate AOA measurements for all the slave sensors.
function angles = Angles_azimuth(Xe,Ye,Xs,Ys,Orientation)

%Determining the angle between sensor and emitter
angles1=atan2((Ye-Ys),(Xe-Xs));

[~,n] = size(Xe);

% To add noise to the AOA measurements, given mean and standard deviation
% For noiseless measurements make the standard deviation as 0 in the
% normrnd
angles=angles1-Orientation+normrnd(0,1,[1,n])*0;
end






