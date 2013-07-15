function [distancePointsExternalContourPieces, distancePointsInternalContourPieces]=analyzeContourPointsDistances(pStructProcessGenericPieceReference, pStructProcessGenericPieceOne)

    distancePointsExternalContourPieces=infinites(360, 1);
    distancePointsInternalContourPieces=infinites(360, 1);

    if (isempty(pStructProcessGenericPieceReference)==1)||(isempty(pStructProcessGenericPieceOne)==1)
        warndlg('Input argument (process generic pieces) is empty.', ' Warning ');
        return;
    end
    
    infoPointsExternalContourPieceReference=pStructProcessGenericPieceReference.InfoPointsExternalContour;
    infoPointsInternalContourPieceReference=pStructProcessGenericPieceReference.InfoPointsInternalContour;
    infoAngleSlotPieceReference=pStructProcessGenericPieceReference.InfoAngleSlot;
    infoPointsExternalContourPieceOne=pStructProcessGenericPieceOne.InfoPointsExternalContour;
    infoPointsInternalContourPieceOne=pStructProcessGenericPieceOne.InfoPointsInternalContour;
    infoAngleSlotPieceOne=pStructProcessGenericPieceOne.InfoAngleSlot;

    %Based on axis of symmetry of the part
            
    angleSlotMeanPieceReference=mean(infoAngleSlotPieceReference,2);
    angleSlotMeanComplementaryPieceReference=round(mod(angleSlotMeanPieceReference+180,360));
    angleSlotMeanPieceOne=mean(infoAngleSlotPieceOne,2);
    angleSlotMeanComplementaryPieceOne=round(mod(angleSlotMeanPieceOne+180,360));
    
    iPieceReference=angleSlotMeanComplementaryPieceReference;
    iPieceOne=angleSlotMeanComplementaryPieceOne;
    
    angleSlotEndPieceReference=infoAngleSlotPieceReference(2)-1;
    if (angleSlotEndPieceReference==0) angleSlotEndPieceReference=360; end
    angleSlotEndPieceOne=infoAngleSlotPieceOne(2);
    if (angleSlotEndPieceOne==0) angleSlotEndPieceOne=360; end
    
    angleSlotStartPieceReference=mod(infoAngleSlotPieceReference(1)+1,360);
    angleSlotStartPieceOne=mod(infoAngleSlotPieceOne(1)+1,360);
    
    %From mean complementary angle to end angle (piece reference and piece one)
    
    while (iPieceReference~=angleSlotEndPieceReference)&&(iPieceOne~=angleSlotEndPieceOne)
        
        distancePointsExternalContourPieces(iPieceReference,1)=infoPointsExternalContourPieceReference(iPieceReference,3)-infoPointsExternalContourPieceOne(iPieceOne,3);
        distancePointsInternalContourPieces(iPieceReference,1)=infoPointsInternalContourPieceReference(iPieceReference,3)-infoPointsInternalContourPieceOne(iPieceOne,3);
        
        iPieceReference=iPieceReference-1;
        if (iPieceReference==0) iPieceReference=360; end
        iPieceOne=iPieceOne-1;
        if (iPieceOne==0) iPieceOne=360; end
        
    end
    
    if (iPieceReference~=angleSlotEndPieceReference)
        
        while (iPieceOne~=angleSlotEndPieceOne)
        
            distancePointsExternalContourPieces(iPieceReference,1)=infoPointsExternalContourPieceOne(iPieceOne,3)+100;
            distancePointsInternalContourPieces(iPieceReference,1)=infoPointsInternalContourPieceOne(iPieceOne,3)+100;
        
			iPieceReference=iPieceReference-1;
        	if (iPieceReference==0) iPieceReference=360; end
        	iPieceOne=iPieceOne-1;
        	if (iPieceOne==0) iPieceOne=360; end
            
        end
        
    else %(iPieceOne==angleSlotEndPieceOne)
        
        while (iPieceReference~=angleSlotEndPieceReference)
        
            distancePointsExternalContourPieces(iPieceReference,1)=-infoPointsExternalContourPieceReference(iPieceReference,3)-100;
            distancePointsInternalContourPieces(iPieceReference,1)=-infoPointsInternalContourPieceReference(iPieceReference,3)-100;
			
            iPieceReference=iPieceReference-1;
        	if (iPieceReference==0) iPieceReference=360; end
            
        end
        
    end
    
    %From mean complementary angle to start angle (piece reference and piece one)
    
    iPieceReference=angleSlotMeanComplementaryPieceReference;
    iPieceOne=angleSlotMeanComplementaryPieceOne;    
    
    while (iPieceReference~=angleSlotStartPieceReference)&&(iPieceOne~=angleSlotStartPieceOne)
        
        distancePointsExternalContourPieces(iPieceReference,1)=infoPointsExternalContourPieceReference(iPieceReference,3)-infoPointsExternalContourPieceOne(iPieceOne,3);
        distancePointsInternalContourPieces(iPieceReference,1)=infoPointsInternalContourPieceReference(iPieceReference,3)-infoPointsInternalContourPieceOne(iPieceOne,3);

        iPieceReference=mod(iPieceReference,360)+1;
        iPieceOne=mod(iPieceOne,360)+1;
            
    end
    
    if (iPieceReference==angleSlotStartPieceReference)
        
        while (iPieceOne~=angleSlotStartPieceOne)
        
            distancePointsExternalContourPieces(iPieceReference,1)=infoPointsExternalContourPieceOne(iPieceOne,3)+100;
            distancePointsInternalContourPieces(iPieceReference,1)=infoPointsInternalContourPieceOne(iPieceOne,3)+100;

            iPieceReference=mod(iPieceReference,360)+1;
            iPieceOne=mod(iPieceOne,360)+1;            
            
        end
        
    else %(iPieceOne==angleSlotStartPieceOne)
        
        while (iPieceReference~=angleSlotStartPieceReference)
        
            distancePointsExternalContourPieces(iPieceReference,1)=-infoPointsExternalContourPieceReference(iPieceReference,3)-100;
            distancePointsInternalContourPieces(iPieceReference,1)=-infoPointsInternalContourPieceReference(iPieceReference,3)-100;

            iPieceReference=mod(iPieceReference,360)+1;
            
        end
        
    end
    
end
