function isAccepted=isAcceptedTolerances5828001(pStructTolerancesObtained5828001, pRatioPixelInMilimetres)
   
    if (isempty(pStructTolerancesObtained5828001)==1)
        isAccepted=false;
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end    
    
    %verify tolerances
    
    isAccepted=true;
    
    %A (circle representing the external contour)
    %Between 33.75 and 34.50 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained5828001.AToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<33.75)||(toleranceDistanceInMilimetres>34.50)
        warndlg(strcat('A (circle representing the external contour), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension A');
        isAccepted=false;
    end
    
    %B (compute the least squares circle of the internal contour)
    %Between 21.60 and 22.00 milimetres
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained5828001.BToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<21.60)||(toleranceDistanceInMilimetres>22.00)
        warndlg(strcat('B (least squares circle of the internal contour), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension B');
        isAccepted=false;
    end
    
    %C1 (bounding boxes of the hole 1)
    %Minimum 2.50 milimetres (diameter)
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained5828001.C1ToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<2.50)
        warndlg(strcat('C1 (bounding boxes of the hole 1), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension C1');
        isAccepted=false;
    end    
    
    %C2 (bounding boxes of the hole 2)
    %Minimum 2.50 milimetres (diameter)
    
    toleranceDistanceInMilimetres=pStructTolerancesObtained5828001.C2ToleranceDiameter*pRatioPixelInMilimetres;
    
    if (toleranceDistanceInMilimetres<2.50)
        warndlg(strcat('C2 (bounding boxes of the hole 2), distance (mm): ', num2str(toleranceDistanceInMilimetres)), ' No accepted: Dimension C2');
        isAccepted=false;
    end    
    
    %Presence of burrs and external contour circularity test (analyze contour points distances)
    
    burrsValueThresholdInMilimetres=0.8; %In milimetres
    burrsValueThresholdInPixels=burrsValueThresholdInMilimetres/pRatioPixelInMilimetres; %In pixels
    
    for degrees=1:1:360
        
        if (~isinf(pStructTolerancesObtained5828001.BurrsDistancePointsExternalContourPieces(degrees,1)))

            if (abs(pStructTolerancesObtained5828001.BurrsDistancePointsExternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                 
                %warndlg(strcat('Presence of burrs (external contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;
            end    
            if (abs(pStructTolerancesObtained5828001.BurrsDistancePointsInternalContourPieces(degrees,1))>burrsValueThresholdInPixels)                    
                %warndlg(strcat('Presence of burrs (internal contour). Degree: ', num2str(degrees), 'º'), ' Warning ');
                isAccepted=false;                
            end
            
        end
        
    end
    
end
