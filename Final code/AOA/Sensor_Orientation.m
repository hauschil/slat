%% Function to display the orientation of the sensors
function [a,b]=Sensor_Orientation(x,y,z)
lineLength = 1;

angle1 = z;
x1(1) = x;
y1(1) = y;
x1(2) = x1(1) + lineLength * cos(angle1);
y1(2) = y1(1) + lineLength * sin(angle1);
hold on; % Don't blow away the image.
a=x1;
b=y1;
end
