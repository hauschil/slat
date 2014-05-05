%% Function to plot the actual and calibrated sensor and emitter positions
function f=plotting(n,s,xe,ye,Sensor_est,Emitter_est,type)
switch type
    % for plotting the calibration of sensors with known emitter positions
    case 1
        xlim([-3 11])
        ylim([-3 11])
        
        %Plot of actual sensors positions
        handlevector(1)=plot(s(:,1),s(:,2),'k*','MarkerSize',9);
        
        hold on ;
      
        %Plot of estimated sensor positions
        handlevector(2)=plot(Sensor_est(:,1),Sensor_est(:,2),...
            'ro','MarkerSize',8);
        
        legend(handlevector,{'actual sensor position',...
            'estimated sensor position'},'Location','best');
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
        
        %Plot of actual emitter positions
        handlevector1(2)=plot(xe,ye,'kx','MarkerSize',9);
        
        %Plot of estimated sensor positions
        handlevector1(3)=plot(Sensor_est(:,1),Sensor_est(:,2),...
            'ro','MarkerSize',8);
        
        
        %Plot of estimated emitter positions
        handlevector1(4)=plot(Emitter_est(:,1),Emitter_est(:,2),'r*',...
                                'MarkerSize',5);   
        
        xlabel('x-axis');
        ylabel('y-axis');
        title('Simultaneous calibration and tracking');
        legend(handlevector1,{'actual sensor position',...
            'actual emitter positions','estimated sensor position',...
            'estimated emitter positions'},'Location','best');
        hold off;

end


