function saveRatioMilimetresNumber(pNamePieceReference, milimetresNumber)
    
    if (milimetresNumber~=Inf)
        
        nameFileRatioMilimetresNumber=strcat(pNamePieceReference, 'PixelConversion.dat');
        save(nameFileRatioMilimetresNumber, 'milimetresNumber');
    
        messageSaveRatioMilimetresNumber=strcat('Ratio milimetres number (', pNamePieceReference, ') has been saved.');            
        msgbox(messageSaveRatioMilimetresNumber, 'Save ratio', 'help');     
    
    else
        
        warndlg('Input argument (milimetres number) is not valid.', ' Try again ');
        return;
        
    end    
        
end
