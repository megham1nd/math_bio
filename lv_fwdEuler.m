function LV_fwdEuler
    %LV model constants
    R0U = 0.04;
    R0V = 0.2;
    gamma = 0.0005;
    e = 0.1;
    
    dT = 0.01; %delta tau (in days)
    maxT = 365; %max t
    t=0:dT:maxT;
    X = zeros(size(t)); %initializing rabbit matrix
    Y = zeros(size(t)); % initializing fox matrix
    numIter=(maxT/dT); %number of iterations
    
    X(1)= 4000; %initial x value
    Y(1) = 80; %initial y value
    
    for i=1:numIter
        %rabbit update function
        X(i+1)=X(i)+u(X(i),Y(i))*dT;
        %fox update function
        Y(i+1)=Y(i)+v(X(i),Y(i))*dT;
    end

%   x is u(t) and y is v(t)
%   PREY FUNCTION -> RABBITS
    function du_dt = u(x, y)
        du_dt = (R0U*x)-(gamma*x*y);
    end
%   PREDATOR FUNCTION -> FOXES
    function dv_dt = v(x, y)
        dv_dt = (e*gamma*x*y)-(R0V*y);
    end

     figure(1);
     plot(t, X, 'b'); 
     hold on
     plot (t, Y, 'c');
     hold off
     xlim([0 365]);
     ylim([0 4500]);
     
     xlabel('days');
     ylabel('population size');
     legend('rabbits', 'foxes');
    
     figure(2);
     plot(X, Y, 'g');
     xlabel('rabbits');
     ylabel('foxes');
     
     hold on
     
     [UU, VV] = meshgrid([0:0.1e4:2e4], [0:100:1200])
     vel_U = (R0U.*UU)-(gamma.*UU.*VV);
     vel_V = (e*gamma.*UU.*VV)-(R0V.*VV);
     h = quiver(UU, VV, vel_U, vel_V, 1.25);
     set(h, 'maxheadsize', 0.005, 'color', [150, 255, 150]/255);
      
     xlim([3995 4005]);
     ylim([75 85]);
      
     hold off
end