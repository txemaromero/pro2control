function showGenericPiece(structProcessGenericPiece, pMilimetresNumber, pShowDetailsFlag)

    if (isempty(structProcessGenericPiece)==1)
        warndlg('Image processing failed.', ' Warning ');
        return;
    end
        
    figure('Name', 'External (blue) and internal (green) contour points: distance');
    xlabel('degrees (from 1 to 360)');
    ylabel('distance (in mm)');
            
    infoPointsExternalContour=structProcessGenericPiece.InfoPointsExternalContour;
    infoPointsInternalContour=structProcessGenericPiece.InfoPointsInternalContour;
    dimensionPiece=structProcessGenericPiece.Dimension;
    outputImage=zeros(dimensionPiece);
        
    for i=1:1:360
            
        xCoordinatesPointExternalContour=infoPointsExternalContour(i,1);
        
        if (~isinf(xCoordinatesPointExternalContour))
           
            yCoordinatesPointExternalContour=infoPointsExternalContour(i,2);
            xCoordinatesPointInternalContour=infoPointsInternalContour(i,1);
            yCoordinatesPointInternalContour=infoPointsInternalContour(i,2);
            distancePointExternalContour=infoPointsExternalContour(i,3);
            distancePointInternalContour=infoPointsInternalContour(i,3);
            outputImage(xCoordinatesPointExternalContour, yCoordinatesPointExternalContour)=1;
            outputImage(xCoordinatesPointInternalContour, yCoordinatesPointInternalContour)=1;            
            
            yAxisPlotExternalContour=distancePointExternalContour*pMilimetresNumber; % pixels to milimetres
            yAxisPlotInternalContour=distancePointInternalContour*pMilimetresNumber;
            
            hold on;
            plot(i,yAxisPlotExternalContour,'bv');
            plot(i,yAxisPlotInternalContour,'g^');
            hold off;
            
        end
        
    end
    
    figure('Name', 'Image Piece: Contour');
    imshow(screenDisplayingAtScale(outputImage, [1 1]));    
        
    %Show details
    
    if (pShowDetailsFlag)
        
        figure('Name', 'Image Piece: Original');
        imshow(screenDisplayingAtScale(structProcessGenericPiece.Image, [1 1]));

        figure('Name', 'Image Piece: Boundaries');
        imshow(screenDisplayingAtScale(label2rgb(structProcessGenericPiece.StatsImages, @jet), [1 1]));
        
    end
    
end
