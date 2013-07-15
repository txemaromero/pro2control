function structProcessGenericPiece=processGenericPiece(pImagePiece)
  
    tic;

    structProcessGenericPiece={};
    
    %grayscale image
    
    imagePieceGrayscale=rgb2gray(pImagePiece);
    
    %binarisation
    
    imagePieceBinary=imagePieceGrayscale<120;
    imagePieceBW=bwareaopen(imagePieceBinary,50);
    dimension=size(imagePieceBinary);
    [imagePieceBW, thresh]=edge(imagePieceBinary, 'sobel');
    
    clear imagePieceGrayscale imagePieceBinary;

    %determine borders and to show the different detected objects.

    [imagePieceBWBoundaries,L]=bwboundaries(imagePieceBW,'noholes');
    
    clear imagePieceBWBoundaries imagePieceBW;

    %

    statsObjects=regionprops(L, 'Area', 'Centroid', 'EquivDiameter', 'PixelList');
    imagePieceBWOneObject=ismember(L,1);
    
    infoPointsBWOneObjectExternalContour=detectExternalContourImageBinary(imagePieceBWOneObject);
    [x0, y0]=obtainParametersCircle(infoPointsBWOneObjectExternalContour, false);
    imagePieceBWOneObjectFilled=imfill(imagePieceBWOneObject, 'holes');
    [infoPointsBWOneObjectExternalContour, infoPointsBWOneObjectInternalContour]=revolvingRay(imagePieceBWOneObjectFilled, [x0 y0]);
    infoAngleSlot=extractAngleContour(infoPointsBWOneObjectExternalContour);
    
    clear imagePieceBWOneObject;
    
    maxDistancePointBWOneObjectExternalContour=-1;
    maxDistancePointBWOneObjectExternalContourByAngle=-1;
    minDistancePointBWOneObjectInternalContour=Inf;
    minDistancePointBWOneObjectInternalContourByAngle=Inf;

    for i=1:1:360
        xCoordinatesPointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(i,1);
        if (~isinf(xCoordinatesPointBWOneObjectExternalContour))
            
            distancePointBWOneObjectExternalContour=infoPointsBWOneObjectExternalContour(i,3);
            distancePointBWOneObjectInternalContour=infoPointsBWOneObjectInternalContour(i,3);
            
            if (distancePointBWOneObjectInternalContour<minDistancePointBWOneObjectInternalContour)
                minDistancePointBWOneObjectInternalContour=distancePointBWOneObjectInternalContour;
                minDistancePointBWOneObjectInternalContourByAngle=i;
            end
            
            if (distancePointBWOneObjectExternalContour>maxDistancePointBWOneObjectExternalContour)
                maxDistancePointBWOneObjectExternalContour=distancePointBWOneObjectExternalContour;
                maxDistancePointBWOneObjectExternalContourByAngle=i;
            end
        end
    end

    structProcessGenericPiece=struct('DimensionDescription', {'Dimension of the piece'}, 'Dimension', {dimension}, 'ImageDescription', {'Image piece'}, 'Image', {pImagePiece}, 'CenterDescription', {'Center point'}, 'CenterCoordinates', {[x0 y0]}, 'InfoPointsContourDescription', {'Information about contour points (external and internal) of the piece'}, 'InfoPointsExternalContour', {infoPointsBWOneObjectExternalContour}, 'InfoPointsInternalContour', {infoPointsBWOneObjectInternalContour}, 'InfoAngleSlotDescription', {'Slot (start and end angle)'}, 'InfoAngleSlot', {infoAngleSlot}, 'MaxDistancePointExternalContourByAngleDescription', {'Circle representing the external contour'}, 'MaxDistancePointExternalContourByAngle', {maxDistancePointBWOneObjectExternalContourByAngle}, 'MinDistancePointInternalContourByAngleDescription', {'Least squares circle of the internal contour'}, 'MinDistancePointInternalContourByAngle', {minDistancePointBWOneObjectInternalContourByAngle}, 'StatsDescription', {'Information about the detected objects in the piece'}, 'StatsObjects', {statsObjects}, 'StatsImages', {L});

    clear imagePieceBWOneObjectFilled infoPointsBWOneObjectExternalContour infoPointsBWOneObjectInternalContour statsObjects L;
    
    disp('Processing a image piece (about algorithm efficiency) ...'); toc
    
end
