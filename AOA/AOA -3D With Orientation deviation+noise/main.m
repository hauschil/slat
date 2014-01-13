%Getting the number of sensors from the user
s=xlsread('Sensor_data');
n=size(s,1);

%Intial conditiion for angle of elevation
[x0_elevation]=[0.7 0.7 0.7]

%Intial conditiion for angle of elevation
[x0_azimuth]=[0.7 0.7 0.7 0] 

%defining variables used optimization function
CostFunction_elevation = @myfun_elevation
CostFunction_azimuth = @myfun_azimuth

%tag position of x,y and z 
xe= [3 5 7] % emitter values vector
ye=[2 4 8]% emitter values vector
ze=[3 2 4]%emitter values in z direction

%Orientation of sensor
angle_deviation = .5

%Angle of elevation in Degrees
measured_angle_sensor_elevation_deg=[26.56 36.86 49.39; 30.96 40 45  ; 32 44 48; 35 38.65 50] %Measured angles from the system
%Conversion of Angle of elevation in Radians
measured_angle_sensor_elevation = deg2rad(measured_angle_sensor_elevation_deg)
%adding orientation in angle of elevation
elevation_angles_deviation = measured_angle_sensor_elevation + angle_deviation


%Angle of Azimuth in Degrees
measured_angle_sensor_azimuth_deg=[47.98 78.69 71.62; 35 30 40 ; 35 40 55 ; 40 45 60]
%Conversion of Angle of Azimuth in Radians
measured_angle_sensor_azimuth = deg2rad(measured_angle_sensor_azimuth_deg)


[m,e]=size(measured_angle_sensor_elevation_deg)

% addition of noise in system acquired elevation angles %
[noise_addition_angle_elevation] = elevation_angles_deviation + elevation_angles_deviation.*normrnd(0,1,[m,e])*0.001

%adding orientation in angle of Azimuth
azimuth_angles_deviation = measured_angle_sensor_azimuth + angle_deviation

% addition of noise in system acquired azimuth angles %
noise_addition_angle_azimuth =azimuth_angles_deviation +azimuth_angles_deviation.*normrnd(0,1,[m,e])*0.1


optim_val_elevation=zeros(n,3)
optim_val_azimuth=zeros(n,4)


for i=1:n
%least square non-linear Optimization for Angle of elevation which will give x,y and orientation
x_elevation = lsqnonlin(@(x)CostFunction_elevation(x,xe,ye,noise_addition_angle_elevation(i,:)),x0_elevation)% least square non-linear optamization function call

optim_val_elevation(i,:) =x_elevation
%least square non-linear Optimization for Angle of Azimuth which will give x,y,z and orientation
x_azimuth = lsqnonlin(@(x)CostFunction_azimuth(x,xe,ye,ze,noise_addition_angle_azimuth(i,:)),x0_azimuth)

optim_val_azimuth(i,:) =x_azimuth

final_matrix=[optim_val_elevation optim_val_azimuth(:,3) optim_val_azimuth(:,4)]

end 
