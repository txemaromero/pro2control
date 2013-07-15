function [isAccepted, varianceDistanceRegionPoints]=isCircularityMorphologic(pCoordinatesRegionPoints, pRegionCenter, pCircularityValueThreshold)

    [numRegionPoints, dimensionRegionPoints]=size(pCoordinatesRegionPoints);
    isAccepted=false;
    
    if (numRegionPoints<2)
        error('Number of points (input argument) is not sufficient');
    end    
    
    for i=1:1:numRegionPoints
        regionPointDistance=plannerDistance(pRegionCenter, [pCoordinatesRegionPoints(i,1) pCoordinatesRegionPoints(i,2)]);
        distanceRegionPoints(i,1)=regionPointDistance;
    end
    
    meanDistanceRegionPoints=mean(distanceRegionPoints,1);
    varianceDistanceRegionPoints=0;
    
    for i=1:1:numRegionPoints
        varianceDistanceRegionPoints=varianceDistanceRegionPoints+(distanceRegionPoints(i,1)-meanDistanceRegionPoints).^2;
    end
    
    varianceDistanceRegionPoints=(1/(numRegionPoints-1))*varianceDistanceRegionPoints;
    disp(strcat('Variance value (hole) circle: ', num2str(varianceDistanceRegionPoints), '. Circularity value threshold (', num2str(pCircularityValueThreshold), ').'));
    
    if (varianceDistanceRegionPoints<pCircularityValueThreshold)
        isAccepted=true;
    end

end
    