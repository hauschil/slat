function [m,n]= curve(t)                        %this function generates a simulated data based on the selection
switch t                                        %switch Switch among several cases
    
    case 1                                      %first case generates straight line
        disp('curve seleted is a straight line')
        m=0:0.3:6;
        n=m;                              %equation of straight line
        plot(m,n)                           %plot straight line
        title('Straight Line')
        xlabel('X');
        ylabel('Y=f(X)');
        
    case 2                                      %second case generates sinusoidal curve
        disp('curve seleted is a sinusoidal curve')
        m=0:0.2:7;
        n=3*sin(m)+4;                             %equation of sinusoidal function
        plot(m,n)                           %plot sinusoidal
        title('Plot of sin')
        
        xlabel('X');
        ylabel('Y=f(X)');
        
    case 3
        m=0:0.2:6;
        n=(sqrt(3^2-(m-3).^2))+3.5;
        plot(m,n)
        
    case 4
        A = zeros(0,2);
        B = zeros(0,2);
        C = zeros(0,2);
        D = zeros(0,2);
        
        north = [ 0  1];
        east  = [ 1  0];
        south = [ 0 -1];
        west  = [-1  0];
        
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
        
        plot(A(:,1), A(:,2), 'clipping', 'off')
        
        m=A(:,1)';
        n=A(:,2)';
        
    otherwise
        disp('Curve selection does not exist')
end
