%% Function to plot the actual and calibrated sensor and emitter positions
function f=plotting(n,s,xe,ye,Sensor_est,Orientation_est,Emitter_est,type)
switch type
    % for plotting the calibration of sensors with known emitter positions
    case 1
        xlim([-3 11])
        ylim([-3 11])
        
        %Plot of actual sensors positions
        handlevector(1)=plot(s(:,1),s(:,2),'k*','MarkerSize',9);
        
        hold on ;

        % Plot of actual sensor orientations
        for i=1:n
            [a,b]=Sensor_Orientation(s(i,1),s(i,2),s(i,3));
            handlevector(2)=plot(a,b,'k-');
        end
        
        %Plot of estimated sensor positions
        handlevector(3)=plot(Sensor_est(:,1),Sensor_est(:,2),...
            'ro','MarkerSize',8);
        
        %Plot of estimated sensor orientations
        for i=1:n
            [a,b]=Sensor_Orientation(Sensor_est(i,1),...
                    Sensor_est(i,2),Orientation_est(1,i));
            handlevector(4)=plot(a,b,'r-');
        end 
        legend(handlevector,{'actual sensor position',...
            'actual sensor orientation','estimated sensor position',...
            'estimated sensor orientation'},'Location','best');
        title('Calibration of sensors only');
        xlabel('x-axis');
        ylabel('y-axis');
        hold off;

    %for plotting the calibration of sensors and estimating emitters (SLAT)
    case 2
        xlim([-3 11])
        ylim([-3 11])        
        
        %Plot of actual sensors positions
        handlevector1(1)=plot(s(:,1),s(:,2),'k*','MarkerSize',9);
        hold on ;
               
        % Plot of actual sensor orientations
        for i=1:n
            [a,b]=Sensor_Orientation(s(i,1),s(i,2),s(i,3));
            handlevector1(2)=plot(a,b,'k-');
        end
        
        %Plot of actual emitter positions
        handlevector1(3)=plot(xe,ye,'kx','MarkerSize',9);
        
        %Plot of estimated sensor positions
        handlevector1(4)=plot(Sensor_est(:,1),Sensor_est(:,2),...
            'ro','MarkerSize',8);
        
        %Plot of estimated sensor orientations
        for i=1:n
            [a,b]=Sensor_Orientation(Sensor_est(i,1),Sensor_est(i,2),...
                Orientation_est(1,i));
            handlevector1(5)=plot(a,b,'r-');
        end
        
        %Plot of estimated emitter positions
        handlevector1(6)=plot(Emitter_est(:,1),Emitter_est(:,2),'r*',...
            'MarkerSize',5);        
        xlabel('x-axis');
        ylabel('y-axis');
        title('Simultaneous calibration and tracking');
        legend(handlevector1,{'actual sensor position',...
            'actual sensor orientation','actual emitter positions',...
            'estimated sensor position','estimated sensor orientation',...
            'estimated emitter positions'},'Location','best');
        hold off;

end


