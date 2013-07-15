function isAccepted=isAcceptedTolerances0863012(pStructTolerancesObtained0863012, pRatioPixelInMilimetres)
   
    if (isempty(pStructTolerancesObtained0863012)==1)
        isAccepted=false;
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end    
    
    %verify tolerances
    
    isAccepted=true;
    
    %A (axis of symmetry of the part)
    %Between 3.25 and 3.55 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.AToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<3.25)||(toleranceDistanceInMilimetres>3.55)
        warndlg(strcat('A (axis of symmetry of the part), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension A');
        isAccepted=false;
    end
        
    %B (circle representing the external contour)
    %Between 37.55 and 38.30 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.BToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<37.55)||(toleranceDistanceInMilimetres>38.30)
        warndlg(strcat('B (circle representing the external contour), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension B');
        isAccepted=false;
    end
    
    %C1 (angle slot start)
    %Maximum 5.45 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.C1ToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres>5.45)
        warndlg(strcat('C1 (angle slot start), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension C1');
        isAccepted=false;
    end
    
    %C2 (angle slot end)
    %Maximum 5.45 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.C2ToleranceDistance*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres>5.45)
        warndlg(strcat('C2 (angle slot end), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension C2');
        isAccepted=false;
    end    
    
    %D1 (bounding boxes of the hole 1)
    %Minimum 2.55 milimetres (diameter)
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.D1ToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<2.55)
        warndlg(strcat('D1 (bounding boxes of the hole 1), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension D1');
        isAccepted=false;
    end    
    
    %D2 (bounding boxes of the hole 2)
    %Minimum 2.55 milimetres (diameter)
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained0863012.D2ToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<2.55)
        warndlg(strcat('D2 (bounding boxes of the hole 2), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension D2');
        isAccepted=false;
    end
    
    %Presence of burrs and external contour circularity test (analyze contour points distances)
    
    burrsValueThresholdInMilimetres=0.8; %In milimetres
    burrsValueThresholdInPixels=burrsValueThresholdInMilimetres/pRatioPixelInMilimetres; %In pixels
    
    for degrees=1:1:360
        
        if (~isinf(pStructTolerancesObtained0863012.BurrsDistancePointsExternalContourPieces(degrees,1)))

            if (abs(pStructTolerancesObtained0863012.BurrsDistancePointsExternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                 
                %warndlg(strcat('Presence of burrs (external contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;
            end    
            if (abs(pStructTolerancesObtained0863012.BurrsDistancePointsInternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                    
                %warndlg(strcat('Presence of burrs (internal contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;                
            end               
        end
        
    end    
    
    
end
