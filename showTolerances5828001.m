function showTolerances5828001(pStructTolerancesObtained5828001, pMilimetresNumber, pShowDetailsFlag)

    if (isempty(pStructTolerancesObtained5828001)==1)
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end
    
    %A (circle representing the external contour)
    
    message=strcat('Dimension A (circle representing the external contour), distance: ', num2str(pStructTolerancesObtained5828001.AToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
             
    message=strcat('Dimension A (circle representing the external contour), coordinates: X=', num2str(pStructTolerancesObtained5828001.AToleranceCoordinates(1)), ' Y=', num2str(pStructTolerancesObtained5828001.AToleranceCoordinates(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
    
    %B (compute the least squares circle of the internal contour)

    message=strcat('Dimension B (least squares circle of the internal contour), distance: ', num2str(pStructTolerancesObtained5828001.BToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');
    
    message=strcat('Dimension B (least squares circle of the internal contour), coordinates: X=', num2str(pStructTolerancesObtained5828001.BToleranceCoordinates(1)), ' Y=', num2str(pStructTolerancesObtained5828001.BToleranceCoordinates(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');    
    
    %C (bounding boxes of the 2 holes)
    
    message=strcat('Dimension C1 (hole 1), diameter: ', num2str(pStructTolerancesObtained5828001.C1ToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C (hole 1)', 'help');
    
    message=strcat('Dimension C1 (hole 1), coordinates: X=', num2str(pStructTolerancesObtained5828001.C1ToleranceCentroid(1)), ' Y=', num2str(pStructTolerancesObtained5828001.C1ToleranceCentroid(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C (hole 1)', 'help');
    
    message=strcat('Dimension C2 (hole 2), diameter: ', num2str(pStructTolerancesObtained5828001.C2ToleranceDiameter*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C (hole 2)', 'help');
    
    message=strcat('Dimension C2 (hole 2), coordinates: X=', num2str(pStructTolerancesObtained5828001.C2ToleranceCentroid(1)), ' Y=', num2str(pStructTolerancesObtained5828001.C2ToleranceCentroid(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C (hole 2)', 'help');
    
    %Show details
    
    if (pShowDetailsFlag)
        figure('Name', 'Image Piece: Tolerances A, B and C');
        imshow(screenDisplayingAtScale(pStructTolerancesObtained5828001.PieceTolerancesImage, [1 1]));
    end
    
end
