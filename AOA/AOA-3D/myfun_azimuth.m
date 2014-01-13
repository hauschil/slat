function objective_function_azimuth = myfun_azimuth(x,xe,ye,ze,measured_angle_sensor_azimuth)% objective function

X=xe-x(1);% xe-xs
Y=ye-x(2);%ye-ys
Z=ze-x(3);%ze-zs
%applying Azimuth formula atan(sqrt((ye-ys)^2+(xe-xs)^2)/(ze-zs))
A=(Y.*Y)+(X.*X);
azimuth_distance=sqrt(A);
azimuth_radians = atan2(azimuth_distance,Z);
azimuth_degrees =  azimuth_radians*(180/pi);
%defining objective function, it contains noise and orientation also in the angle of Azimuth    
objective_function_azimuth = measured_angle_sensor_azimuth - azimuth_degrees  %objective function azimuth

end