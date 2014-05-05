%% Objective function to evaluate AOA 
function objective_function_AOA=Calibrate_AOA(x,Sm,ns,xt_known,yt_known,...
                            angles_known,measured_angle_sensor_azimuth)

%concatinating the known and unknown tag positions
for k=ns+ns+1:size(x)
    xt_known=horzcat(xt_known,x(k,1));
    yt_known=horzcat(yt_known,x(k,2));
end
measured_angle_sensor_azimuth=[angles_known,measured_angle_sensor_azimuth];
[~,d]=size(xt_known);

%Equations using the master sensor only
%AOA calculations for the master sensor
for m=1:d
    Xm(1,m)=xt_known(1,m)-Sm(1,1);% xe-xs
    Ym(1,m)=yt_known(1,m)-Sm(1,2);%ye-ys
    AOA_Master(1,m)= atan2(Ym(1,m),Xm(1,m))-Sm(1,3);
end

%Equations for the rest of the sensors

for p=1:ns
    for j=1:d
        X(p,j)=xt_known(j)-x(p,1);% xe-xs
        Y(p,j)=yt_known(j)-x(p,2);%ye-ys
        %radian angle calculation with orientation
        AOA_Slaves(p,j) = atan2(Y(p,j),X(p,j))-x(ns+p,1);
    end
end
%Combining equations for master sensor and slave sensors for AOA 
AOA_all=[AOA_Master;AOA_Slaves];

%Objective function for AOA
objective_function_AOA=measured_angle_sensor_azimuth-AOA_all;

end