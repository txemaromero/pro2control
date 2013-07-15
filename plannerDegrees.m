function angleDegrees=plannerDegrees(pPointOne, pPointTwo)

    x0=pPointOne(1);
    y0=pPointOne(2);
    x1=pPointTwo(1);
    y1=pPointTwo(2);
    
    if (x0>=x1)&&(y0<y1)
        angleDegrees=atan2(x0-x1,y1-y0);
    elseif (x0>=x1)&&(y0>=y1)
        angleDegrees=pi-atan2(x0-x1,y0-y1);
    elseif (x0<x1)&&(y0>=y1)
        angleDegrees=pi+atan2(x1-x0,y0-y1);
    else
        %(x0<x1)&&(y0<y1)
        angleDegrees=2*pi-atan2(x1-x0,y1-y0);
    end
    
    angleDegrees=180*angleDegrees/pi; %degrees
    angleDegrees=mod(round(angleDegrees),360)+1;
    
end
