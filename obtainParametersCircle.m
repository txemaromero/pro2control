function [x0, y0]=obtainParametersCircle(points2D, showDetailsFlag)
    
    %B=A*X
    [numPoints dimensionPoints]=size(points2D);
    for i=1:1:numPoints
        for j=1:1:dimensionPoints
            B(i,:)=[points2D(i,1).^2+points2D(i,2).^2];
            A(i,:)=[1 2*points2D(i,1) 2*points2D(i,2)];
        end
    end
    
    %X=inv(A'*A)*A'*B
    %X=[v x0 y0]
    X=inv(A'*A)*A'*B;
    v=X(1);
    %obtain variable x0, y0 (center)
    x0=round(X(2));
    y0=round(X(3));
    
    %v=r.^2-x0.^2-y0.^2
    %obtain variable r
    r=sqrt(v+x0.^2+y0.^2);
   
    n=50;
    k=0:n;
    fi=2*pi*k/n;
    x=x0+r*cos(fi);
    y=y0+r*sin(fi);
    
    if (showDetailsFlag)
    
        figure('Name', 'Input points (red crosses) and center point (blue cross)');
        plot(x0,y0,'x',x,y);
        hold on;
        for i=1:1:numPoints
            for j=1:1:dimensionPoints
                plot(points2D(i,1), points2D(i,2), 'r*');
            end
        end
        hold off;
    
        disp(strcat('Center point, coordinates: X=', num2str(x0), ' Y=', num2str(y0), '.'));
        
    end    
    
end
