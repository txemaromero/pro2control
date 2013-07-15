function showAnalyzeContourPointsDistances(pStructTolerancesObtained, pMilimetresNumber)

    if (isempty(pStructTolerancesObtained))
        warndlg('Input argument (tolerances obtained) is empty.', ' Warning ');
        return;
    end  

    figure('Name', 'External (cyan), internal (green) contour points and threshold (red): distance (difference between pieces)');
    xlabel('degrees (from 1 to 360)');
    ylabel('distance to reference piece (in mm)');
    
    burrsValueThresholdInMilimetres=0.8; %In milimetres
    
    for i=1:1:360
        
        if (~isinf(pStructTolerancesObtained.BurrsDistancePointsExternalContourPieces(i,1)))
        
            hold on;
            plot(i, burrsValueThresholdInMilimetres, 'r-');
            plot(i, -burrsValueThresholdInMilimetres, 'r-');
            plot(i,pStructTolerancesObtained.BurrsDistancePointsExternalContourPieces(i,1)*pMilimetresNumber,'cv');
            plot(i,pStructTolerancesObtained.BurrsDistancePointsInternalContourPieces(i,1)*pMilimetresNumber,'g^');
            hold off;
        
        end
        
    end
    
end    
