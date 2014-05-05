%%       Algorithm for SLAT using TDOA
%**************************************************************************
%%
%Clearing out the workspace and command window.
clear all;
clc;

%% Generation of simulation data
%**************************************************************************

% To display message on the command window informing the user to define the
% sensor locations in the xls file.
disp('Define all the sensor locations in the file "Sensor_data.xls"')

%Read the sensor data file and import it into a variable
Sensor_all=xlsread('Sensor_data');

%determines the number of sensors in the network
no_sensors=size(Sensor_all,1);

% To display a message on the command window to input the choice of curve.
disp('Select the type of curve to be Simulated for the Calibration')
disp('1= Straight line, 2= Spline1, 3= Spline2, 4= Space filling curve')
choice= input('Enter the choice:')

% The x and y co-ordinates  are gnenrated according to the choice provided.
[x_emitter,y_emitter]= Curve(choice);

%v is the velocity of the radio waves in air in meters per second
v=3e8;

% To Generate TDOA measurements for the Simulated curve
%r0 is distance of emitter from the master sensor
r0=sqrt((x_emitter-Sensor_all(1,1)).^2+(y_emitter-Sensor_all(1,2)).^2);

% Function to generate TDOA measurements given the emitter positions & r0
for i=2:no_sensors
    Slave_sensor=Sensor_all(i,:);
    time_diff(i-1,:)=TimeDifference(r0,x_emitter,y_emitter,Slave_sensor,v);
    % For addition or removal of noise please refer to the function
    % 'timedifference.m'
end
%End of generation of simulation data.

%% Case 1: Calibration of the sensors with known emitter positions
%**************************************************************************

%Master sensor which is calibrated manually
S_master=Sensor_all(1,:);

%Excluding the master sensor which is calibrated manually
no_sensors=no_sensors-1;

%Defining offset from the actual solution in metres
offset=0.5;

% Initial guess for the sensor positions
Sinit=[Sensor_all(2:end,:)+offset*rand([no_sensors,2])];
X0=[Sinit];
xt_known=x_emitter;
yt_known=y_emitter;
td_known=[];

% Calling the LSQNONLIN optimization solver
result=lsqnonlin(@(X)Sensor_Calibrate(X,S_master,time_diff,v,...
    no_sensors,xt_known,yt_known,td_known),(X0));

%Displaying a message on the command window
disp('Sensor calibration results considering with known emitter positions')

%Final result of the estimated sensors.
Sensor_calibrated =result(1:no_sensors,:)
Emitter_estimated=[;];

%Plotting the calibrated sensor positions
figure;
plotting(no_sensors,Sensor_all,x_emitter,y_emitter,Sensor_calibrated,...
    Emitter_estimated,1)

%% Case 2: Simultaneous calibration and tracking
%**************************************************************************
% Splitting the known and unknown data

%Master sensor which is calibrated manually
S_master=Sensor_all(1,:);

%For generating known data vectors
count=1;
xt_known=[];
yt_known=[];

%to generate known data points given the percentage of known data points
P= round(0.2*length(x_emitter));
P= floor(length(x_emitter)/P);
for s=1:P:length(x_emitter)%-rem(length(x_emitter),P)
    if s>length(x_emitter)
        break
    end
    xt_known(count)=x_emitter(1,s);
    yt_known(count)=y_emitter(1,s);
    td_known(:,count)=time_diff(:,s);
    time_diff(:,s)=[];
    x_emitter(:,s)=[];
    y_emitter(:,s)=[];
    count=count+1;
end

% size of known and unknown tag positions
[~,known]=size(xt_known);
[~,unknown]=size(time_diff);


%Defining offset from the actual solution in metres
offset=0.5;

% Initial guess for the sensor and emitter positions
Sinit=[Sensor_all(2:end,:)+offset*rand([no_sensors,2])];
posinit=[x_emitter(1,:)'+offset*rand([unknown,1]),...
    y_emitter(1,:)'+offset*rand([unknown,1])];
X0=[Sinit;posinit];

% Calling the LSQNONLIN optimization solver
result=lsqnonlin(@(X)Sensor_Calibrate(X,S_master,time_diff,v,...
    no_sensors,xt_known,yt_known,td_known),(X0));

%Displaying a message on the command window
disp('The results for simulataneous calibration and tracking')

%Final result of the estimated sensors and emitters
Sensor_estimated=result(1:no_sensors,:)
Emitter_estimated=result(no_sensors+1:end,:)
figure;
plotting(no_sensors,Sensor_all,x_emitter,y_emitter,Sensor_estimated,...
    Emitter_estimated,2)