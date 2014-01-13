function objective_function_elevation = myfun_elevation(x,xe,ye,elevation_angles_deviation)% objective function

X=xe-x(1)% xe-xs
Y=ye-x(2)%ye-ys
deviation_orientation=x(3)

%applying elevation formula: atan2((ye-ys)/(xe-xs))
AOA_radians = atan2(Y,X)%radian angle calculation
%defining objective function, it contains orientation also in the angle of elevation    
objective_function_elevation = elevation_angles_deviation - ( AOA_radians + deviation_orientation )% objective function
    
    end