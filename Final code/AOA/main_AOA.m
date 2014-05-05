%       Algorithm for SLAT using AOA
%**************************************************************************
%%
%Clearing out the workspace and command window.
clear all;
clc;
%% Generation of simulation data
%*********************************************

% To display message on the command window informing the user to define 
% the sensor locations in the xls file
disp('Define all the sensor locations in the file "Sensor_data.xls"')

%Read the sensor data file and import it into an variable
Sensor_all=xlsread('Sensor_data');

%determines the number of sensors in the network
no_sensors=size(Sensor_all,1);

% To display a message on the command window to input the choice of curve.
disp('Select the type of curve to be Simulated for the Calibration')
disp('1= Straight line, 2= Spline1, 3= Spline2, 4= Space filling curve')
choice= input('Enter the choice:')

% The x and y co-ordinates are genenrated according to the choice provided.
[x_emitter,y_emitter]= Curve(choice);
[xe,ye]= Curve(choice);% These are used for ploting our results at 
[~,c]=size(x_emitter);

% To Generate AOA measurements for the Simulated curve
% Function to generate AOA measurements given the emitter positions
for i=1:no_sensors
    Xs=Sensor_all(i,1);
    Ys=Sensor_all(i,2);
    orientation=Sensor_all(i,3);
    for j=1:c
        measured_angle_azimuth(i,j)=Angles_azimuth(x_emitter(j),...
            y_emitter(j),Xs,Ys,orientation);
    end
end
%End of generation of simulation data.

%% Case 1: Calibration of sensors only with known emitters

%Master sensor which is calibrated manually
S_master=Sensor_all(1,:);
no_sensors=no_sensors-1;

xt_known=x_emitter;
yt_known=y_emitter;
angles_known=[];

%Defining offset from the actual solution in metres
offset=0.5;

% Forming the initial guess for sensors
Sinit=Sensor_all(2:end,1:2)+offset*rand([no_sensors,2]);
orientation_init=zeros(no_sensors,2);

X0=[Sinit;orientation_init];

%calling the lsqnonlin optimization solver
result = lsqnonlin(@(X)Calibrate_AOA(X,S_master,no_sensors,...
    xt_known,yt_known,angles_known,...
    measured_angle_azimuth),X0);

%Final result of the estimated sensors
disp('Sensor calibration results considering with known emitter positions')
Sensor_estimated=result(1:no_sensors,:)
Orientation_estimated =result(no_sensors+1:2*no_sensors)
Emitter_estimated=[;];
figure;
plotting(no_sensors,Sensor_all,x_emitter,y_emitter,Sensor_estimated,...
        Orientation_estimated,Emitter_estimated,1)

%% Case 2: Simultaneous calibration and tracking 

xt_known=[];
yt_known=[];
%Master sensor which is calibrated manually
S_master=Sensor_all(1,:);

%Splitting the known and unknown data 
%For generating known data vectors
count=1;

%p is the number of known data points
P= round(0.15*length(x_emitter));
P= floor(length(x_emitter)/P);
for s=1:P:length(x_emitter)%-rem(length(x_emitter),P)
    if s>length(x_emitter)
        break
    end
    xt_known(count)=x_emitter(1,s);
    yt_known(count)=y_emitter(1,s);
    angles_known(:,count)=measured_angle_azimuth(:,s);
    measured_angle_azimuth(:,s)=[];
    x_emitter(:,s)=[];
    y_emitter(:,s)=[];
    count=count+1;
end

% size of known and unknown tag positions
[~,known]=size(xt_known);
[~,unknown]=size(measured_angle_azimuth);

% Initial guess for the sensor and emitter positions
%offset value
offset=1;

% Forming the initial guess for sensors
Sinit=Sensor_all(2:end,1:2)+offset*rand([no_sensors,2]);
orientation_init=zeros(3,2);

%Forming the initial guess for emitter positions
posinit=[x_emitter'+offset*rand([unknown,1]),...
        y_emitter'+offset*rand([unknown,1])];
X0=[Sinit;orientation_init;posinit];

%Call the lsqnonlin optimization solver
result = lsqnonlin(@(X)Calibrate_AOA(X,S_master,no_sensors,...
    xt_known,yt_known,angles_known,...
    measured_angle_azimuth),X0);

%Final result of the estimated sensors and emitters
disp('The results for simulataneous calibration and tracking')
Sensor_estimated=result(1:no_sensors,:)
Orientation_estimated =result(no_sensors+1:2*no_sensors)
Emitter_estimated=result(2*no_sensors+1:end,:)
figure;
plotting(no_sensors,Sensor_all,x_emitter,y_emitter,Sensor_estimated,...
        Orientation_estimated,Emitter_estimated,2)