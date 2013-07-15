function [structTolerancesObtained, structProcessGenericPiece]=demandedTolerancesIA04(pImagePiece, pStructProcessGenericPieceReference)

    tic;

    structTolerancesObtained={};
    structProcessGenericPiece=processGenericPiece(pImagePiece);
    
    if (isempty(structProcessGenericPiece))
        warndlg('Image processing failed.', ' Warning ');
        return;
    end
            
    %verify tolerances
      
    infoPointsBWOneObjectExternalContour=structProcessGenericPiece.InfoPointsExternalContour;
    infoPointsBWOneObjectInternalContour=structProcessGenericPiece.InfoPointsInternalContour;
    infoAngleSlot=structProcessGenericPiece.InfoAngleSlot;
    minDistancePointBWOneObjectInternalContourByAngle=structProcessGenericPiece.MinDistancePointInternalContourByAngle;
    statsObjects=structProcessGenericPiece.StatsObjects;  
    
    if (length(statsObjects)~=1)
        warndlg('Piece image is not valid (IA04).', ' Warning ');
        return;
    end
    
    clear statsObjects;
    
    %A (compute the least squares circle of the internal contour)
            
    xCoordinatesMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,1);
    yCoordinatesMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,2);
    distanceMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,3);

    %A (image piece with its tolerances)
    
    x0=structProcessGenericPiece.CenterCoordinates(1);
    y0=structProcessGenericPiece.CenterCoordinates(2);
    imagePieceBWOneObjectWithItsTolerances=ismember(structProcessGenericPiece.StatsImages,1);
    
    imagePieceBWOneObjectWithItsTolerances=circleDiscontinuousLine([x0 y0], distanceMinDistancePointBWOneObjectInternalContour, imagePieceBWOneObjectWithItsTolerances);
    
    %B
            
    xCoordinatesPointBWOneObjectInfoAngleSlotStart=infoPointsBWOneObjectExternalContour(infoAngleSlot(1),1);
    yCoordinatesPointBWOneObjectInfoAngleSlotStart=infoPointsBWOneObjectExternalContour(infoAngleSlot(1),2);
    coordinatesPointBWOneObjectInfoAngleSlotStart=[xCoordinatesPointBWOneObjectInfoAngleSlotStart yCoordinatesPointBWOneObjectInfoAngleSlotStart];

    xCoordinatesPointBWOneObjectInfoAngleSlotEnd=infoPointsBWOneObjectExternalContour(infoAngleSlot(2),1);
    yCoordinatesPointBWOneObjectInfoAngleSlotEnd=infoPointsBWOneObjectExternalContour(infoAngleSlot(2),2);
    coordinatesPointBWOneObjectInfoAngleSlotEnd=[xCoordinatesPointBWOneObjectInfoAngleSlotEnd yCoordinatesPointBWOneObjectInfoAngleSlotEnd];         
            
    distanceBWOneObjectInfoAngleSlot=plannerDistance(coordinatesPointBWOneObjectInfoAngleSlotStart, coordinatesPointBWOneObjectInfoAngleSlotEnd);
    
    %B (image piece with its tolerances)
    
    imagePieceBWOneObjectWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWOneObjectWithItsTolerances, xCoordinatesPointBWOneObjectInfoAngleSlotStart, yCoordinatesPointBWOneObjectInfoAngleSlotStart, xCoordinatesPointBWOneObjectInfoAngleSlotEnd, yCoordinatesPointBWOneObjectInfoAngleSlotEnd);
            
    %C (mean value of profile part widths)
    
    indexAngleDegrees=find(~isinf(infoPointsBWOneObjectExternalContour(:,3)));
                
    distancePartWidthsExternalContour=infoPointsBWOneObjectExternalContour(indexAngleDegrees,3);
    distancePartWidthsInternalContour=infoPointsBWOneObjectInternalContour(indexAngleDegrees,3);
            
    distancePartWidthsExternalContourMean=mean(distancePartWidthsExternalContour,1);
    distancePartWidthsInternalContourMean=mean(distancePartWidthsInternalContour,1);
    distancePartWidthsMean=distancePartWidthsExternalContourMean-distancePartWidthsInternalContourMean;
           
    %C (image piece with its tolerances)
    
    imagePieceBWOneObjectWithItsTolerances=circleDiscontinuousLine([x0 y0], distancePartWidthsInternalContourMean+distancePartWidthsMean/2, imagePieceBWOneObjectWithItsTolerances);
            
    %Analyze contour points distances (presence of burrs)
    
    if (exist('IA04ProcessPiece.dat')==2)
        load('IA04ProcessPiece.dat', '-mat');
    else
        warndlg('IA04 process piece database not found.', ' Warning ');
        return;
    end    
    
    [distancePointsExternalContourPieces, distancePointsInternalContourPieces]=analyzeContourPointsDistances(pStructProcessGenericPieceReference, structProcessGenericPiece);
    structTolerancesObtained=struct('NamePieceReference', {'IA04'}, 'AToleranceDescription', {'Least squares circle of the internal contour'}, 'AToleranceDistance', {distanceMinDistancePointBWOneObjectInternalContour}, 'AToleranceCoordinates', {[xCoordinatesMinDistancePointBWOneObjectInternalContour yCoordinatesMinDistancePointBWOneObjectInternalContour]}, 'BToleranceDescription', {'Angle slot distance'}, 'BToleranceAngleSlot', {infoAngleSlot}, 'BToleranceDistance', {distanceBWOneObjectInfoAngleSlot}, 'CToleranceDescription', {'Mean value of profile part widths'}, 'CToleranceDistance', {distancePartWidthsMean}, 'BurrsDescription', {'Analyze contour (external and internal) points distances (to reference piece)'}, 'BurrsDistancePointsExternalContourPieces', {distancePointsExternalContourPieces}, 'BurrsDistancePointsInternalContourPieces', {distancePointsInternalContourPieces}, 'PieceTolerancesDescription', {'Image piece with its tolerances'}, 'PieceTolerancesImage', {imagePieceBWOneObjectWithItsTolerances});   
    
    clear infoPointsBWOneObjectExternalContour infoPointsBWOneObjectInternalContour infoAngleSlot minDistancePointBWOneObjectInternalContourByAngle statsObjects imagePieceBWOneObjectWithItsTolerances;
    
    disp('IA04 Tolerances (about algorithm efficiency) ...'); toc
    
end
