function showTolerances0863012(pStructTolerancesObtained0863012, pMilimetresNumber, pShowDetailsFlag)

    if (isempty(pStructTolerancesObtained0863012)==1)
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end

    %A (axis of symmetry of the part)

    message=strcat('Dimension A (axis of symmetry of the part), distance: ', num2str(pStructTolerancesObtained0863012.AToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
             
    message=strcat('Dimension A (axis of symmetry of the part), angle: ', num2str(pStructTolerancesObtained0863012.AToleranceAngle), ' degrees.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
    
    %B (circle representing the external contour)
    
    message=strcat('Dimension B (circle representing the external contour), distance: ', num2str(pStructTolerancesObtained0863012.BToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');
             
    message=strcat('Dimension B (circle representing the external contour), coordinates: X=', num2str(pStructTolerancesObtained0863012.BToleranceCoordinates(1)), ' Y=', num2str(pStructTolerancesObtained0863012.BToleranceCoordinates(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');
    
    %C
    
    message=strcat('Dimension C1 (angle slot start), distance: ', num2str(pStructTolerancesObtained0863012.C1ToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C1 (angle slot start)', 'help');
    
    message=strcat('Dimension C2 (angle slot end), distance: ', num2str(pStructTolerancesObtained0863012.C2ToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C2 (angle slot end)', 'help');
    
    %D (bounding boxes of the 2 holes)
    
    message=strcat('Dimension D1 (hole 1), diameter: ', num2str(pStructTolerancesObtained0863012.D1ToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): D (hole 1)', 'help');
    
    message=strcat('Dimension D1 (hole 1), coordinates: X=', num2str(pStructTolerancesObtained0863012.D1ToleranceCentroid(1)), ' Y=', num2str(pStructTolerancesObtained0863012.D1ToleranceCentroid(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): D (hole 1)', 'help');
    
    message=strcat('Dimension D2 (hole 2), diameter: ', num2str(pStructTolerancesObtained0863012.D2ToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): D (hole 2)', 'help');
    
    message=strcat('Dimension D2 (hole 2), coordinates: X=', num2str(pStructTolerancesObtained0863012.D2ToleranceCentroid(1)), ' Y=', num2str(pStructTolerancesObtained0863012.D2ToleranceCentroid(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): D (hole 2)', 'help');
    
    %Show details
    
    if (pShowDetailsFlag)
        figure('Name', 'Image Piece: Tolerances A, B, C and D');
        imshow(screenDisplayingAtScale(pStructTolerancesObtained0863012.PieceTolerancesImage, [1 1]));
    end
    
end
