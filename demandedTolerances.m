function [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances(pNamePieceReference, pStructProcessGenericPieceReference)

    structTolerancesObtained={};
    structProcessGenericPiece={};

    [nameFileImage,pathNameImage]=uigetfile({strcat(pNamePieceReference, '*.jpg'), strcat(pNamePieceReference, ' Image Files (', pNamePieceReference, '*.jpg)')}, 'Select an image');
                                      
    if (nameFileImage==0)
        warndlg('Image not selected.', ' Warning ');
        return;
    end
    
    imagePiece=imread(strcat(pathNameImage, nameFileImage));

    if (strcmp(pNamePieceReference,'IA04')==1)
        
        [structTolerancesObtained, structProcessGenericPiece]=demandedTolerancesIA04(imagePiece, pStructProcessGenericPieceReference);
        
    elseif (strcmp(pNamePieceReference,'0863-012')==1)
        
        [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances0863012(imagePiece, pStructProcessGenericPieceReference);
        
    elseif (strcmp(pNamePieceReference,'5828-001')==1)
        
        [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances5828001(imagePiece, pStructProcessGenericPieceReference);
        
    else
        
        warndlg(strcat('Piece reference (', pNamePieceReference, ') is not registered.'), ' Warning ');
        
    end
 
end
