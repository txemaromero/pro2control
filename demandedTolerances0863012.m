function [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances0863012(pImagePiece, pStructProcessGenericPieceReference)

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
    maxDistancePointBWOneObjectExternalContourByAngle=structProcessGenericPiece.MaxDistancePointExternalContourByAngle;
    statsObjects=structProcessGenericPiece.StatsObjects;
    
    if (length(statsObjects)~=3)
        warndlg('Piece image does not have 2 holes.', ' Warning ');
        return;
    end
             
    %A (axis of symmetry of the part)
                
    x0=structProcessGenericPiece.CenterCoordinates(1);
    y0=structProcessGenericPiece.CenterCoordinates(2);
    
    centroidTwoObject=statsObjects(2).Centroid;
    centroidThreeObject=statsObjects(3).Centroid;
    
    angleCentroidTwoObject=plannerDegrees([x0 y0], [centroidTwoObject(2) centroidTwoObject(1)]);
    angleCentroidThreeObject=plannerDegrees([x0 y0], [centroidThreeObject(2) centroidThreeObject(1)]);
    
    angleSlotMean=mean([angleCentroidTwoObject angleCentroidThreeObject]);
    angleSlotMeanComplementary=round(mod(angleSlotMean+180,360));
    
    distanceAngleSlotMeanComplementaryExternalContour=infoPointsBWOneObjectExternalContour(angleSlotMeanComplementary,3);
    distanceAngleSlotMeanComplementaryInternalContour=infoPointsBWOneObjectInternalContour(angleSlotMeanComplementary,3);
    distanceAngleSlotMeanComplementaryPartWidth=distanceAngleSlotMeanComplementaryExternalContour-distanceAngleSlotMeanComplementaryInternalContour;    
    
    %A (image piece with its tolerances)
        
    imagePieceBWWithItsTolerances=ismember(structProcessGenericPiece.StatsImages,1);
    imagePieceBWWithItsTolerances=imagePieceBWWithItsTolerances+ismember(structProcessGenericPiece.StatsImages,2);
    imagePieceBWWithItsTolerances=imagePieceBWWithItsTolerances+ismember(structProcessGenericPiece.StatsImages,3);
        
    xCoordinatesAngleSlotMeanComplementaryExternalContour=infoPointsBWOneObjectExternalContour(angleSlotMeanComplementary,1);
    yCoordinatesAngleSlotMeanComplementaryExternalContour=infoPointsBWOneObjectExternalContour(angleSlotMeanComplementary,2);
    xCoordinatesAngleSlotMeanComplementaryInternalContour=infoPointsBWOneObjectInternalContour(angleSlotMeanComplementary,1);
    yCoordinatesAngleSlotMeanComplementaryInternalContour=infoPointsBWOneObjectInternalContour(angleSlotMeanComplementary,2);        
        
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, xCoordinatesAngleSlotMeanComplementaryExternalContour, yCoordinatesAngleSlotMeanComplementaryExternalContour, xCoordinatesAngleSlotMeanComplementaryInternalContour, yCoordinatesAngleSlotMeanComplementaryInternalContour);
             
    %B (circle representing the external contour)
            
    xCoordinatesMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,1);
    yCoordinatesMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,2);
    distanceMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,3);        
    
    %B (image piece with its tolerances)
    
    imagePieceBWWithItsTolerances=circleDiscontinuousLine([x0 y0], distanceMaxDistancePointBWOneObjectExternalContour, imagePieceBWWithItsTolerances);
             
    %C
    
    angleSlotStart=infoAngleSlot(1);
    for i=1:1:3
        angleSlotStart=angleSlotStart-1;
        if (angleSlotStart==0) angleSlotStart=360; end
    end
    
    distancePointInfoAngleSlotStartExternalContour=infoPointsBWOneObjectExternalContour(angleSlotStart,3);
    distancePointInfoAngleSlotStartInternalContour=infoPointsBWOneObjectInternalContour(angleSlotStart,3);
    distanceAngleSlotStart=distancePointInfoAngleSlotStartExternalContour-distancePointInfoAngleSlotStartInternalContour;
    
    angleSlotEnd=infoAngleSlot(2);
    angleSlotEnd=mod(angleSlotEnd+3,360);
    
    distancePointInfoAngleSlotEndExternalContour=infoPointsBWOneObjectExternalContour(angleSlotEnd,3);
    distancePointInfoAngleSlotEndInternalContour=infoPointsBWOneObjectInternalContour(angleSlotEnd,3);    
    distanceAngleSlotEnd=distancePointInfoAngleSlotEndExternalContour-distancePointInfoAngleSlotEndInternalContour;
    
    %C (image piece with its tolerances)
    
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, infoPointsBWOneObjectInternalContour(angleSlotStart,1), infoPointsBWOneObjectInternalContour(angleSlotStart,2), infoPointsBWOneObjectExternalContour(angleSlotStart,1), infoPointsBWOneObjectExternalContour(angleSlotStart,2));
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, infoPointsBWOneObjectInternalContour(angleSlotEnd,1), infoPointsBWOneObjectInternalContour(angleSlotEnd,2), infoPointsBWOneObjectExternalContour(angleSlotEnd,1), infoPointsBWOneObjectExternalContour(angleSlotEnd,2));
          
    %D (bounding boxes of the 2 holes) 
             
    pixelListTwoObject=statsObjects(2).PixelList;
    
    xCoordinatesAPixelTwoObject=pixelListTwoObject(1,2);
    yCoordinatesAPixelTwoObject=pixelListTwoObject(1,1);
    
    equivDiameterTwoObject=plannerDistance([centroidTwoObject(2) centroidTwoObject(1)], [xCoordinatesAPixelTwoObject yCoordinatesAPixelTwoObject])*2;
             
    [isAccepted, varianceDistanceRegionPoints]=isCircularityMorphologic(pixelListTwoObject, centroidTwoObject, 0.9);
    
    if (isAccepted==false)
        warndlg('Hole 1 is not circular.', ' Warning ');
    end                           
             
    pixelListThreeObject=statsObjects(3).PixelList;
    
    xCoordinatesAPixelThreeObject=pixelListThreeObject(1,2);
    yCoordinatesAPixelThreeObject=pixelListThreeObject(1,1);    
    
    equivDiameterThreeObject=plannerDistance([centroidThreeObject(2) centroidThreeObject(1)], [xCoordinatesAPixelThreeObject yCoordinatesAPixelThreeObject])*2;
    
    clear statsObjects;
             
    [isAccepted, varianceDistanceRegionPoints]=isCircularityMorphologic(pixelListThreeObject, centroidThreeObject, 0.9);                       
             
    if (isAccepted==false)
        warndlg('Hole 2 is not circular.', ' Warning ');
    end
    
    %D (show details)
       
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, xCoordinatesAPixelTwoObject, yCoordinatesAPixelTwoObject, centroidTwoObject(2), centroidTwoObject(1));
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, xCoordinatesAPixelThreeObject, yCoordinatesAPixelThreeObject, centroidThreeObject(2), centroidThreeObject(1));    
                          
    %Analyze contour points distances (presence of burrs)
    
    if (exist('0863012ProcessPiece.dat')==2)
        load('0863012ProcessPiece.dat', '-mat');
    else
        warndlg('0863-012 process piece database not found.', ' Warning ');
        return;
    end    
    
    [distancePointsExternalContourPieces, distancePointsInternalContourPieces]=analyzeContourPointsDistances(pStructProcessGenericPieceReference, structProcessGenericPiece);      
    structTolerancesObtained=struct('NamePieceReference', {'0863-012'}, 'AToleranceDescription', {'Axis of symmetry of the part'}, 'AToleranceDistance', {distanceAngleSlotMeanComplementaryPartWidth}, 'AToleranceAngle', {angleSlotMeanComplementary}, 'BToleranceDescription', {'Circle representing the external contour'}, 'BToleranceDiameter', {distanceMaxDistancePointBWOneObjectExternalContour*2}, 'BToleranceCoordinates', {[xCoordinatesMaxDistancePointBWOneObjectExternalContour yCoordinatesMaxDistancePointBWOneObjectExternalContour]}, 'C1ToleranceDescription', {'Angle slot start'}, 'C1ToleranceDistance', {distanceAngleSlotStart}, 'C2ToleranceDescription', {'Angle slot end'}, 'C2ToleranceDistance', {distanceAngleSlotEnd}, 'D1ToleranceDescription', {'Hole 1'}, 'D1ToleranceDiameter', {equivDiameterTwoObject}, 'D1ToleranceCentroid', {[centroidTwoObject(2) centroidTwoObject(1)]}, 'D2ToleranceDescription', {'Hole 2'}, 'D2ToleranceDiameter', {equivDiameterThreeObject}, 'D2ToleranceCentroid', {[centroidThreeObject(2) centroidThreeObject(1)]}, 'BurrsDescription', {'Analyze contour (external and internal) points distances (to reference piece)'}, 'BurrsDistancePointsExternalContourPieces', {distancePointsExternalContourPieces}, 'BurrsDistancePointsInternalContourPieces', {distancePointsInternalContourPieces}, 'PieceTolerancesDescription', {'Image piece with its tolerances'}, 'PieceTolerancesImage', {imagePieceBWWithItsTolerances}); 
    
    clear infoPointsBWOneObjectExternalContour infoPointsBWOneObjectInternalContour infoAngleSlot maxDistancePointBWOneObjectExternalContourByAngle statsObjects imagePieceBWWithItsTolerances;
    
    disp('0863-012 Tolerances (about algorithm efficiency) ...'); toc
    
end
