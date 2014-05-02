%% Function to generate simulated path of the emitter
function [x,y]= Curve(t)

%switch Switch among several cases
switch t
    
    %first case generates straight line
    case 1
        disp('curve selected is a straight line')
        x=0:0.1:6;
        y=0.35*x+1;
        
        %plot straight line
        plot(x,y,'+','MarkerSize',5)
        title('Straight Line')
        xlabel('X');
        ylabel('Y=f(X)');
        
    %second case generates spline curve
    case 2
        disp('curve selected is a sinusoidal curve')
        x=1:0.2:7;
        y=sin(4*x)+cos(x)+0.7*x;
        
        %plot the spline1
        plot(x,y,'+','MarkerSize',5)
        title('Plot of spline1')
        xlabel('X');
        ylabel('Y=f(X)');
        
    %third case generates a spline curve
    case 3
        x=1:0.1:6;
        y=(sqrt(3^2-(x-3).^2))+1;
        
        %Plot the spline2
        plot(x,y,'+','MarkerSize',5)
        title('Plot of spline2')
        xlabel('X');
        ylabel('Y=f(X)');
        
    % fourth case generates the Hilbet's spsce filling curve
    case 4
        A = zeros(0,2);
        B = zeros(0,2);
        C = zeros(0,2);
        D = zeros(0,2);
        
        north = [ 0  1];
        east  = [ 1  0];
        south = [ 0 -1];
        west  = [-1  0];
        
        %Order of the hilbert's space filling curve is 3
        order = 3;
        for n = 1:order
            AA = [B ; north ; A ; east  ; A ; south ; C];
            BB = [A ; east  ; B ; north ; B ; west  ; D];
            CC = [D ; west  ; C ; south ; C ; east  ; A];
            DD = [C ; south ; D ; west  ; D ; north ; B];
            
            A = AA;
            B = BB;
            C = CC;
            D = DD;
        end
        
        A = [0 0; cumsum(A)];
        x=A(:,1)';
        y=A(:,2)';
        
        %plot the hilbert's space filling curve
        plot(x, y,'x')
        title('Plot of hilberts space filling curve')
        xlabel('X');
        ylabel('Y=f(X)');
        
    otherwise
        %Invalid case
        disp('Curve selection does not exist')
end
