function objective_function_azimuth = myfun_azimuth(x,xe,ye,ze,noise_addition_angle_azimuth)% objective function

X=xe-x(1);% xe-xs
Y=ye-x(2);%ye-ys
Z=ze-x(3);%ze-zs
deviation_orientation=x(4);
%applying Azimuth formula atan(sqrt((ye-ys)^2+(xe-xs)^2)/(ze-zs)) 
A=(Y.*Y)+(X.*X);
azimuth_distance=sqrt(A);
azimuth_radians = atan2(azimuth_distance,Z);
%defining objective function, it contains noise and orientation also in the angle of Azimuth 
objective_function_azimuth = noise_addition_angle_azimuth - (azimuth_radians + deviation_orientation)  %objective function azimuth
end