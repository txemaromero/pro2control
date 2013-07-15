function outputImage=circleDiscontinuousLine(pCenter, pR, pImage)

    x0=pCenter(1);
    y0=pCenter(2);
    outputImage=pImage;
    
    for angleDegrees=1:1:360
        
        radians=angleDegrees*pi/180;
        
        x1=x0-pR*sin(radians);
        y1=y0+pR*cos(radians);
        x1=round(x1);
        y1=round(y1);
        outputImage(x1,y1)=1;
        
    end
    
end
