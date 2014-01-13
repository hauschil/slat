function objective_function_elevation = myfun_elevation(x,xe,ye,measured_angle_sensor_elevation)% objective function

X=xe-x(1);% xe-xs
Y=ye-x(2);%ye-ys
%applying elevation formula: atan2((ye-ys)/(xe-xs))
AOA_radians = atan2(Y,X);%radian angle calculation
AOA_degrees = AOA_radians*(180/pi);% degrees angle calculation
%defining objective function, it contains noise and orientation also in the angle of elevation 
objective_function_elevation = measured_angle_sensor_elevation- AOA_degrees% objective function
    
end