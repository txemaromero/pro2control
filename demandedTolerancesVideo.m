function [framesStructTolerancesObtained, framesStructProcessGenericPiece]=demandedTolerancesVideo(pNamePieceReference, pStructProcessGenericPieceReference)

    framesStructTolerancesObtained={};
    framesStructProcessGenericPiece={};
    
    [nameFileVideo,pathNameVideo]=uigetfile({strcat(pNamePieceReference, '*.avi'), strcat(pNamePieceReference, ' Video Files (', pNamePieceReference, '*.avi)')}, 'Select a video');
                                      
    if (nameFileVideo==0)
        warndlg('Video not selected.', ' Warning ');
        return;
    end
    
    statsVideo=aviinfo(strcat(pathNameVideo, nameFileVideo))
    
    if (statsVideo.NumFrames==0)
        warndlg('Video with 0 frames.', ' Warning ');
        return;
    end    
    
    video=aviread(strcat(pathNameVideo, nameFileVideo));
    imshow(screenDisplayingAtScale(video(1).cdata, [0.75 0.75]));
    movie(video);
    
    if (strcmp(pNamePieceReference, 'IA04'))
    
        for i=1:1:statsVideo.NumFrames
    
            imagePiece=video(i).cdata;
            [structTolerancesObtained, structProcessGenericPiece]=demandedTolerancesIA04(imagePiece, pStructProcessGenericPieceReference);
            framesStructTolerancesObtained{i,1}=structTolerancesObtained;
            framesStructProcessGenericPiece{i,1}=structProcessGenericPiece;
            
        end
        
    elseif (strcmp(pNamePieceReference, '0863-012'))
        
        for i=1:1:statsVideo.NumFrames
    
            imagePiece=video(i).cdata;
            [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances0863012(imagePiece, pStructProcessGenericPieceReference);
            framesStructTolerancesObtained{i,1}=structTolerancesObtained;
            framesStructProcessGenericPiece{i,1}=structProcessGenericPiece;
            
        end        
        
    elseif (strcmp(pNamePieceReference, '5828-001'))
        
        for i=1:1:statsVideo.NumFrames
    
            imagePiece=video(i).cdata;
            [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances5828001(imagePiece, pStructProcessGenericPieceReference);
            framesStructTolerancesObtained{i,1}=structTolerancesObtained;
            framesStructProcessGenericPiece{i,1}=structProcessGenericPiece;
            
        end        
        
    end
    
end
