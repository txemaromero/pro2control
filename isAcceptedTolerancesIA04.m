function isAccepted=isAcceptedTolerancesIA04(pStructTolerancesObtainedIA04, pRatioPixelInMilimetres)
   
    if (isempty(pStructTolerancesObtainedIA04)==1)
        isAccepted=false;
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end    
    
    %verify tolerances
    
    isAccepted=true;
    
    %A (compute the least squares circle of the internal contour)
    %Between 11.56 and 12.11 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtainedIA04.AToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<11.56)||(toleranceDistanceInMilimetres>12.11)
        warndlg(strcat('A (least squares circle of the internal contour), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension A');
        isAccepted=false;
    end
        
    %B
    %Between 4 and 6.5 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtainedIA04.BToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<4)||(toleranceDistanceInMilimetres>6.5)
        warndlg(strcat('B (angle slot), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension B');
        isAccepted=false;
    end
    
    %C (mean value of profile part widths)
    %Between 2.25 and 2.5 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtainedIA04.CToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<2.25)||(toleranceDistanceInMilimetres>2.5)
        warndlg(strcat('C (mean value of profile part widths), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension C');
        isAccepted=false;
    end
    
    %Presence of burrs and external contour circularity test (analyze contour points distances)
    
    burrsValueThresholdInMilimetres=0.8; %In milimetres
    burrsValueThresholdInPixels=burrsValueThresholdInMilimetres/pRatioPixelInMilimetres; %In pixels
    
    for degrees=1:1:360
        
        if (~isinf(pStructTolerancesObtainedIA04.BurrsDistancePointsExternalContourPieces(degrees,1)))

            if (abs(pStructTolerancesObtainedIA04.BurrsDistancePointsExternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                 
                %warndlg(strcat('Presence of burrs (external contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;
            end    
            if (abs(pStructTolerancesObtainedIA04.BurrsDistancePointsInternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                    
                %warndlg(strcat('Presence of burrs (internal contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;                
            end
            
        end
        
    end
    
end
