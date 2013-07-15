function infoAngleSlot=extractAngleContour(infoPointsExternalContour)

    infoAngleSlot=[Inf Inf];

    sizeInfoPointsExternalContour=size(infoPointsExternalContour);
    numPointsExternalContour=sizeInfoPointsExternalContour(1);
    
    if (numPointsExternalContour<2)
        warndlg('Input argument (infoPointsExternalContour) is wrong.', ' Warning ');
        return;
    end

    for i=1:1:numPointsExternalContour
        j=mod(i,numPointsExternalContour)+1;
        
        if (isinf(infoPointsExternalContour(i,3)))
            if (~isinf(infoPointsExternalContour(j,3)))
                angleSlotEnd=j;
            end
        else
            if (isinf(infoPointsExternalContour(j,3)))
                angleSlotStart=i;
            end
        end   
    end
        
    infoAngleSlot=[angleSlotStart angleSlotEnd];
    
end
