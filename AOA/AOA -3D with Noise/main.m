%Getting the number of sensors from the user
s=xlsread('Sensor_data');
n=size(s,1);

%Intial conditiion for angle of elevation
[x0_elevation]=[-100 -100]; % initial guess
%Intial conditiion for angle of elevation
[x0_azimuth]=[-100 -100 -100]; % initial guess

%defining variables used optimization function
CostFunction_elevation = @myfun_elevation
CostFunction_azimuth = @myfun_azimuth

%tag position of x,y and z 
xe= [3 5 7]; % emitter values vector
ye=[2 4 8];% emitter values vector
ze=[3 2 4];%emitter values in z direction

%Angle of elevation in Degrees
measured_angle_sensor_elevation=[26.56 36.86 49.39; 30.96 45 39.79  ; 33.42 68.19 80.53; 71.56 38.65 33.42]; %Measured angles from the system

% size of elevation angles acquired from system %
[m,e]=size(measured_angle_sensor_elevation)

% addition of noise in system acquired elevation angles %

noise_addition_angle_elevation = measured_angle_sensor_elevation + measured_angle_sensor_elevation.*normrnd(0,1,[m,e])*0.01;

% azimuth acquired from system %

measured_angle_sensor_azimuth=[47.98 78.69 71.62; 80.26 61.99 75.61 ; 74.47 79.47 63.43 ; 81.008 64.850 42.01];

% addition of noise in system acquired azimuth angles %

noise_addition_angle_azimuth = measured_angle_sensor_azimuth + measured_angle_sensor_azimuth.*normrnd(0,1,[m,e])*0.01

% optimal matrix for x & y coordinates obtained after elevation angle optimization %

optim_val_elevation=zeros(n,2);

% optimal matrix for x & y & z coordinates obtained after azimuth angle optimization %

optim_val_azimuth=zeros(n,3);


for i=1:n
    
% least square non-linear Optimization for Angle of elevation which will give x,y
x_elevation = lsqnonlin(@(x)CostFunction_elevation(x,xe(i),ye(i),noise_addition_angle_elevation(i,:)),x0_elevation);

optim_val_elevation(i,:) =x_elevation

%least square non-linear Optimization for Angle of Azimuth which will give x,y,z
x_azimuth = lsqnonlin(@(x)CostFunction_azimuth(x,xe(i),ye(i),ze(i),noise_addition_angle_azimuth(i,:)),x0_azimuth);

optim_val_azimuth(i,:) =x_azimuth;

final_matrix=[optim_val_elevation optim_val_azimuth(:,3)]

end 

