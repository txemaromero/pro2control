function showTolerancesIA04(pStructTolerancesObtainedIA04, pMilimetresNumber, pShowDetailsFlag)

    if (isempty(pStructTolerancesObtainedIA04)==1)
        warndlg('Tolerances processing failed.', ' Warning ');
        return;
    end

    %A (compute the least squares circle of the internal contour)

    message=strcat('Dimension A (least squares circle of the internal contour), distance: ', num2str(pStructTolerancesObtainedIA04.AToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
    
    message=strcat('Dimension A (least squares circle of the internal contour), coordinates: X=', num2str(pStructTolerancesObtainedIA04.AToleranceCoordinates(1)), ' Y=', num2str(pStructTolerancesObtainedIA04.AToleranceCoordinates(2)), '.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): A', 'help');
    
    %B
    
    message=strcat('Dimension B (angle slot), angle: from ', num2str(pStructTolerancesObtainedIA04.BToleranceAngleSlot(1)), ' to ', num2str(pStructTolerancesObtainedIA04.BToleranceAngleSlot(2)), ' degrees.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');            
            
    message=strcat('Dimension B (angle slot), distance: ', num2str(pStructTolerancesObtainedIA04.BToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): B', 'help');
    
    %C (mean value of profile part widths)
    
    message=strcat('Dimension C (mean value of profile part widths), distance: ', num2str(pStructTolerancesObtainedIA04.CToleranceDistance*pMilimetresNumber), ' mm.');
    disp(message);            
    msgbox(message, 'Database result (tolerance): C', 'help');
    
    %Show details
    
    if (pShowDetailsFlag)
        figure('Name', 'Image Piece: Tolerances A, B and C');
        imshow(screenDisplayingAtScale(pStructTolerancesObtainedIA04.PieceTolerancesImage, [1 1]));
    end
    
end
