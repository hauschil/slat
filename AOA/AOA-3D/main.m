%Getting the number of sensors from the user
s=xlsread('Sensor_data');
n=size(s,1);

%Intial conditiion for angle of elevation
[x0_elevation]=[0.7 0.7]; % initial guess

%Intial conditiion for angle of elevation
[x0_azimuth]=[0.7 0.7 0.7]; % initial guess

%defining variables used optimization function
CostFunction_elevation = @myfun_elevation
CostFunction_azimuth = @myfun_azimuth


%tag position of x,y and z 
xe= [3 5 7; 7 6 8; 9 5 4; 6 9 7]; % emitter values vector
ye=[2 4 8; 5 6 7; 7 8 9 ;  10 8 6];% emitter values vector
ze=[3 2 4; 3 5 4; 5 4 6 ; 5 7 8];%emitter values in z direction


%Angle of elevation in Degrees
measured_angle_sensor_elevation=[26.56 36.86 49.39; 30.96 45 39.79  ; 33.42 68.19 80.53; 71.56 38.65 33.42]; %Measured angles from the system
%Angle of Azimuth in Degrees
measured_angle_sensor_azimuth=[47.98 78.69 71.62; 80.26 61.99 75.61 ; 74.47 79.47 63.43 ; 81.008 64.850 42.01];

optim_val_elevation=zeros(n,2);
optim_val_azimuth=zeros(n,3);


for i=1:n
%Optimization for Angle of elevation which will give x,y 
x_elevation = lsqnonlin(@(x)CostFunction_elevation(x,xe(i,:),ye(i,:),measured_angle_sensor_elevation(i,:)),x0_elevation);% least square non-linear optamization function call

optim_val_elevation(i,:) =x_elevation;
%Optimization for Angle of Azimuth which will give x,y,z
x_azimuth = lsqnonlin(@(x)CostFunction_azimuth(x,xe(i,:),ye(i,:),ze(i,:),measured_angle_sensor_azimuth(i,:)),x0_azimuth);

optim_val_azimuth(i,:) =x_azimuth;

final_matrix=[optim_val_elevation optim_val_azimuth(:,3)]

end 

