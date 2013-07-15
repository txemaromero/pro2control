function [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances5828001(pImagePiece, pStructProcessGenericPieceReference)

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
    maxDistancePointBWOneObjectExternalContourByAngle=structProcessGenericPiece.MaxDistancePointExternalContourByAngle;
    minDistancePointBWOneObjectInternalContourByAngle=structProcessGenericPiece.MinDistancePointInternalContourByAngle;
    statsObjects=structProcessGenericPiece.StatsObjects;
    
    if (length(statsObjects)~=3)
        warndlg('Piece image does not have 2 holes.', ' Warning ');
        return;
    end
             
    %A (circle representing the external contour)    
            
    xCoordinatesMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,1);
    yCoordinatesMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,2);
    distanceMaxDistancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(maxDistancePointBWOneObjectExternalContourByAngle,3);
       
    %A (image piece with its tolerances)
    
    x0=structProcessGenericPiece.CenterCoordinates(1);
    y0=structProcessGenericPiece.CenterCoordinates(2);
        
    imagePieceBWWithItsTolerances=ismember(structProcessGenericPiece.StatsImages,1);
    imagePieceBWWithItsTolerances=imagePieceBWWithItsTolerances+ismember(structProcessGenericPiece.StatsImages,2);
    imagePieceBWWithItsTolerances=imagePieceBWWithItsTolerances+ismember(structProcessGenericPiece.StatsImages,3);
    
    imagePieceBWWithItsTolerances=circleDiscontinuousLine([x0 y0], distanceMaxDistancePointBWOneObjectExternalContour, imagePieceBWWithItsTolerances);
             
    %B (compute the least squares circle of the internal contour)
            
    xCoordinatesMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,1);
    yCoordinatesMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,2);
    distanceMinDistancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(minDistancePointBWOneObjectInternalContourByAngle,3);    
    
    %B (image piece with its tolerances)
    
    imagePieceBWWithItsTolerances=circleDiscontinuousLine([x0 y0], distanceMinDistancePointBWOneObjectInternalContour, imagePieceBWWithItsTolerances);
          
    %C (bounding boxes of the 2 holes) 
             
    centroidTwoObject=statsObjects(2).Centroid;
    pixelListTwoObject=statsObjects(2).PixelList;
    
    xCoordinatesAPixelTwoObject=pixelListTwoObject(1,2);
    yCoordinatesAPixelTwoObject=pixelListTwoObject(1,1);
    
    equivDiameterTwoObject=plannerDistance([centroidTwoObject(2) centroidTwoObject(1)], [xCoordinatesAPixelTwoObject yCoordinatesAPixelTwoObject])*2;         
             
    [isAccepted, varianceDistanceRegionPoints]=isCircularityMorphologic(pixelListTwoObject, centroidTwoObject, 0.9);
    
    if (isAccepted==false)
        warndlg('Hole 1 is not circular.', ' Warning ');
    end                           
             
    centroidThreeObject=statsObjects(3).Centroid;
    pixelListThreeObject=statsObjects(3).PixelList;
    
    xCoordinatesAPixelThreeObject=pixelListThreeObject(1,2);
    yCoordinatesAPixelThreeObject=pixelListThreeObject(1,1);
    
    equivDiameterThreeObject=plannerDistance([centroidThreeObject(2) centroidThreeObject(1)], [xCoordinatesAPixelThreeObject yCoordinatesAPixelThreeObject])*2;
    
    clear statsObjects;
             
    [isAccepted, varianceDistanceRegionPoints]=isCircularityMorphologic(pixelListThreeObject, centroidThreeObject, 0.9);                       
             
    if (isAccepted==false)
        warndlg('Hole 2 is not circular.', ' Warning ');
    end
    
    %C (show details)
       
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, xCoordinatesAPixelTwoObject, yCoordinatesAPixelTwoObject, centroidTwoObject(2), centroidTwoObject(1));
    imagePieceBWWithItsTolerances=bresenhamDiscontinuousLine(imagePieceBWWithItsTolerances, xCoordinatesAPixelThreeObject, yCoordinatesAPixelThreeObject, centroidThreeObject(2), centroidThreeObject(1));    
                          
    %Analyze contour points distances (presence of burrs)
    
    if (exist('5828001ProcessPiece.dat')==2)
        load('5828001ProcessPiece.dat', '-mat');
    else
        warndlg('5828-001 process piece database not found.', ' Warning ');
        return;
    end    
    
    [distancePointsExternalContourPieces, distancePointsInternalContourPieces]=analyzeContourPointsDistances(pStructProcessGenericPieceReference, structProcessGenericPiece);      
    structTolerancesObtained=struct('NamePieceReference', {'5828-001'}, 'AToleranceDescription', {'Circle representing the external contour'}, 'AToleranceDiameter', {distanceMaxDistancePointBWOneObjectExternalContour*2}, 'AToleranceCoordinates', {[xCoordinatesMaxDistancePointBWOneObjectExternalContour yCoordinatesMaxDistancePointBWOneObjectExternalContour]}, 'BToleranceDescription', {'Compute the least squares circle of the internal contour'}, 'BToleranceDiameter', {distanceMinDistancePointBWOneObjectInternalContour*2}, 'BToleranceCoordinates', {[xCoordinatesMinDistancePointBWOneObjectInternalContour yCoordinatesMinDistancePointBWOneObjectInternalContour]}, 'C1ToleranceDescription', {'Hole 1'}, 'C1ToleranceDiameter', {equivDiameterTwoObject}, 'C1ToleranceCentroid', {[centroidTwoObject(2) centroidTwoObject(1)]}, 'C2ToleranceDescription', {'Hole 2'}, 'C2ToleranceDiameter', {equivDiameterThreeObject}, 'C2ToleranceCentroid', {[centroidThreeObject(2) centroidThreeObject(1)]}, 'BurrsDescription', {'Analyze contour (external and internal) points distances (to reference piece)'}, 'BurrsDistancePointsExternalContourPieces', {distancePointsExternalContourPieces}, 'BurrsDistancePointsInternalContourPieces', {distancePointsInternalContourPieces}, 'PieceTolerancesDescription', {'Image piece with its tolerances'}, 'PieceTolerancesImage', {imagePieceBWWithItsTolerances}); 
    
    clear infoPointsBWOneObjectExternalContour infoPointsBWOneObjectInternalContour maxDistancePointBWOneObjectExternalContourByAngle minDistancePointBWOneObjectInternalContourByAngle statsObjects imagePieceBWWithItsTolerances;
    
    disp('5828-001 Tolerances (about algorithm efficiency) ...'); toc
    
end
