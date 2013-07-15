function saveProcessGenericPiece(pNamePieceReference, structProcessGenericPieceReference)
    
    if (isempty(structProcessGenericPieceReference))
        warndlg('Input argument (process piece) is empty.', ' Try again ');
        return;
    end    

    nameFileProcessPiece=strcat(pNamePieceReference, 'ProcessPiece.dat');
    save(nameFileProcessPiece, 'structProcessGenericPieceReference');    
    
    messageSaveProcessPiece=strcat('Piece tolerances (', pNamePieceReference, ') have been saved.');            
    msgbox(messageSaveProcessPiece, 'Save information about process piece', 'help');     
    
end
