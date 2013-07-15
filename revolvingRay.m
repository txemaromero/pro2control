function [infoPointsExternalContour, infoPointsInternalContour]=revolvingRay(pImageBinary, pCenter)

    x0=pCenter(1);
    y0=pCenter(2);
    dimension=size(pImageBinary);
    maxAxesX=dimension(1);
    maxAxesY=dimension(2);
    
    infoPointsInternalContour=infinites(360,3);
    infoPointsExternalContour=infinites(360,3);
    
    for angleDegrees=1:1:360
        
        radians=angleDegrees*pi/180;
        
        r=0;
        x1=x0;
        y1=y0;
        
        internalPointDetected=false;
        
        while (~internalPointDetected)&&(x1<=maxAxesX)&&(x1>0)&&(y1<=maxAxesY)&&(y1>0)
            
            if (pImageBinary(x1,y1)==1)
                
                degrees=plannerDegrees([x0 y0], [x1 y1]);
                distance=plannerDistance([x0 y0], [x1 y1]);
                infoPointsInternalContour(degrees,1)=x1;
                infoPointsInternalContour(degrees,2)=y1;
                infoPointsInternalContour(degrees,3)=distance;
                
                infoPointsExternalContour(degrees,1)=x1;
                infoPointsExternalContour(degrees,2)=y1;
                infoPointsExternalContour(degrees,3)=distance;
                
                internalPointDetected=true;
            
            end
            
            r=r+1;
            [incx,incy]=pol2cart(radians,r);
            incx=round(incx);
            incy=round(incy);
            
            x1=x0+incx;
            y1=y0+incy;
            
        end
        
        while (x1<=maxAxesX)&&(x1>0)&&(y1<=maxAxesY)&&(y1>0)
            
            if (pImageBinary(x1,y1)==1)
                
                degrees=plannerDegrees([x0 y0], [x1 y1]);
                distance=plannerDistance([x0 y0], [x1 y1]);
                infoPointsExternalContour(degrees,1)=x1;
                infoPointsExternalContour(degrees,2)=y1;
                infoPointsExternalContour(degrees,3)=distance;
                
            end
            
            r=r+1;
            [incx,incy]=pol2cart(radians,r);
            incx=round(incx);
            incy=round(incy);
            
            x1=x0+incx;
            y1=y0+incy;          
            
        end
                
    end
    
end
