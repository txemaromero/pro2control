
clc;
close all;
clear all;

if (exist('IA04ProcessPiece.dat')==2)
    buttonIA04MainReferenceImages='IA04 (show info ...)';
else
    buttonIA04MainReferenceImages='IA04 (not defined)';
end

if (exist('0863012ProcessPiece.dat')==2)
    button0863012MainReferenceImages='0863-012 (show info ...)';
else
    button0863012MainReferenceImages='0863-012 (not defined)';
end

if (exist('5828001ProcessPiece.dat')==2)
    button5828001MainReferenceImages='5828-001 (show info ...)';
else
    button5828001MainReferenceImages='5828-001 (not defined)';
end

optionMain=0;
exitMain=5;

while (optionMain~=exitMain)
    
    optionMain=menu('Quality control of mechanical pieces by artificial vision', '[Step 1] Reference image pieces (0 defaults) ...', '[Step 2] Capture tolerances ...', 'Learn about application ...', 'About Pro2Control ...', 'Exit');

    if (optionMain==1) %[Step 1] Reference image pieces (0 defaults) ...
        
        optionMainReferenceImages=0;
        exitMainReferenceImages=5;
        
        while (optionMainReferenceImages~=exitMainReferenceImages)   
        
            optionMainReferenceImages=menu('Reference image pieces', buttonIA04MainReferenceImages, button0863012MainReferenceImages, button5828001MainReferenceImages, 'Delete databases', 'Return to Main menu');
    
            if (optionMainReferenceImages==1)
            
                if (strcmp(buttonIA04MainReferenceImages, 'IA04 (not defined)'))

                    [nameFileImage,pathNameImage]=uigetfile({'IA04*.jpg', 'IA04 Image Files (IA04*.jpg)'}, 'Select an image');
                                      
                    if (nameFileImage==0)
                        warndlg('Image not selected.', ' Warning ');
                       
                    else
                        milimetresNumber=Inf;
                        while (milimetresNumber==Inf)
                            milimetresNumber=insertRatioMilimetresNumberMenu('IA04');
                        end
                        
                        saveRatioMilimetresNumber('IA04', milimetresNumber);
                        imagePiece=imread(strcat(pathNameImage, nameFileImage));
                        structProcessGenericPieceReference=processGenericPiece(imagePiece);
                        disp(' ');
                        clear imagePiece;
                        
                        if (isempty(structProcessGenericPieceReference))
                            warndlg('Image processing failed. Try again', ' Warning ');
                        else
                            buttonIA04MainReferenceImages='IA04 (show info ...)';
                            saveProcessGenericPiece('IA04', structProcessGenericPieceReference);
                        end
                        
                        clear structProcessGenericPieceReference;
                        
                    end   
            
                else
            
                    if (exist('IA04ProcessPiece.dat')==2)
                        load('IA04ProcessPiece.dat', '-mat');
                        if (exist('IA04PixelConversion.dat')==2)
                            load('IA04PixelConversion.dat', '-mat');
                            msgbox(strcat('IA04: 1 pixel per ', num2str(milimetresNumber), ' milimetres.'), 'Number of milimetres added to IA04 pixel conversion database', 'help');                            
                            showGenericPiece(structProcessGenericPieceReference, milimetresNumber, true);
                        else
                            warndlg('IA04 pixel conversion database not found. Delete databases.', ' Warning ');
                        end    
                    else
                        warndlg('IA04 process piece database not found.', ' Warning ');
                    end
                end    
            
            elseif (optionMainReferenceImages==2)
            
                if (strcmp(button0863012MainReferenceImages, '0863-012 (not defined)'))                    

                    [nameFileImage,pathNameImage]=uigetfile({'0863-012*.jpg', '0863-012 Image Files (0863-012*.jpg)'}, 'Select an image');
                                      
                    if (nameFileImage==0)
                        warndlg('Image not selected.', ' Warning ');
                       
                    else
                        milimetresNumber=Inf;
                        while (milimetresNumber==Inf)
                            milimetresNumber=insertRatioMilimetresNumberMenu('0863012');
                        end                        
                        
                        saveRatioMilimetresNumber('0863012', milimetresNumber);
                        imagePiece=imread(strcat(pathNameImage, nameFileImage));
                        structProcessGenericPieceReference=processGenericPiece(imagePiece);
                        disp(' ');
                        clear imagePiece;
            
                        if (isempty(structProcessGenericPieceReference))
                            warndlg('Image processing failed. Try again', ' Warning ');
                        else
                            button0863012MainReferenceImages='0863-012 (show info ...)';
                            saveProcessGenericPiece('0863012', structProcessGenericPieceReference);
                        end
                        
                        clear structProcessGenericPieceReference;
                        
                    end   
            
                else
            
                    if (exist('0863012ProcessPiece.dat')==2)
                        load('0863012ProcessPiece.dat', '-mat');
                        
                        if (exist('0863012PixelConversion.dat')==2)
                            load('0863012PixelConversion.dat', '-mat');
                            msgbox(strcat('0863-012: 1 pixel per ', num2str(milimetresNumber), ' milimetres.'), 'Number of milimetres added to 0863-012 pixel conversion database', 'help');
                            showGenericPiece(structProcessGenericPieceReference, milimetresNumber, true);
                        else
                            warndlg('0863-012 pixel conversion database not found. Delete databases.', ' Warning ');
                        end
                        
                    else
                        warndlg('0863-012 process piece database not found.', ' Warning ');
                    end
                end
                
            elseif (optionMainReferenceImages==3)
            
                if (strcmp(button5828001MainReferenceImages, '5828-001 (not defined)'))                    

                    [nameFileImage,pathNameImage]=uigetfile({'5828-001*.jpg', '5828-001 Image Files (5828-001*.jpg)'}, 'Select an image');
                                      
                    if (nameFileImage==0)
                        warndlg('Image not selected.', ' Warning ');
                       
                    else
                        milimetresNumber=Inf;
                        while (milimetresNumber==Inf)
                            milimetresNumber=insertRatioMilimetresNumberMenu('5828001');
                        end                        
                        
                        saveRatioMilimetresNumber('5828001', milimetresNumber);
                        imagePiece=imread(strcat(pathNameImage, nameFileImage));
                        structProcessGenericPieceReference=processGenericPiece(imagePiece);
                        disp(' ');
                        clear imagePiece;
            
                        if (isempty(structProcessGenericPieceReference))
                            warndlg('Image processing failed. Try again', ' Warning ');
                        else
                            button5828001MainReferenceImages='5828-001 (show info ...)';
                            saveProcessGenericPiece('5828001', structProcessGenericPieceReference);
                        end
                        
                        clear structProcessGenericPieceReference;
                        
                    end   
            
                else
            
                    if (exist('5828001ProcessPiece.dat')==2)
                        load('5828001ProcessPiece.dat', '-mat');
                        
                        if (exist('5828001PixelConversion.dat')==2)
                            load('5828001PixelConversion.dat', '-mat');
                            msgbox(strcat('5828-001: 1 pixel per ', num2str(milimetresNumber), ' milimetres.'), 'Number of milimetres added to 5828-001 pixel conversion database', 'help');
                            showGenericPiece(structProcessGenericPieceReference, milimetresNumber, true);
                        else
                            warndlg('5828-001 pixel conversion database not found. Delete databases.', ' Warning ');
                        end
                        
                    else
                        warndlg('5828-001 process piece database not found.', ' Warning ');
                    end
                end                
                
            elseif (optionMainReferenceImages==4)
                
            	if (exist('IA04ProcessPiece.dat')==2)
                        
                    button=questdlg('You will remove the IA04 database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('IA04ProcessPiece.dat');
                        msgbox('IA04 process piece database was successfully removed from the current directory.', 'Database removed', 'help');
                        buttonIA04MainReferenceImages='IA04 (not defined)';
                    end
                
                end
                
                if (exist('0863012ProcessPiece.dat')==2)
                        
                    button=questdlg('You will remove the 0863-012 database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('0863012ProcessPiece.dat');
                        msgbox('0863-012 process piece database was successfully removed from the current directory.', 'Database removed', 'help');
                        button0863012MainReferenceImages='0863-012 (not defined)';
                    end
                
                end
                
                if (exist('5828001ProcessPiece.dat')==2)
                        
                    button=questdlg('You will remove the 5828-001 database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('5828001ProcessPiece.dat');
                        msgbox('5828-001 process piece database was successfully removed from the current directory.', 'Database removed', 'help');
                        button5828001MainReferenceImages='5828-001 (not defined)';
                    end
                
                end                
                
                if (exist('IA04PixelConversion.dat')==2)
                
                    button=questdlg('You will remove the IA04 pixel conversion database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('IA04PixelConversion.dat');
                        msgbox('IA04 pixel conversion database was successfully removed from the current directory.', 'Database removed', 'help');
                    end
                
                end
                
                if (exist('0863012PixelConversion.dat')==2)
                
                    button=questdlg('You will remove the 0863-012 pixel conversion database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('0863012PixelConversion.dat');
                        msgbox('0863-012 pixel conversion database was successfully removed from the current directory.', 'Database removed', 'help');
                    end
                    
                end
                
                if (exist('5828001PixelConversion.dat')==2)
                
                    button=questdlg('You will remove the 5828-001 pixel conversion database ...', 'Reference image pieces');
                    if strcmp(button, 'Yes')
                        delete('5828001PixelConversion.dat');
                        msgbox('5828-001 pixel conversion database was successfully removed from the current directory.', 'Database removed', 'help');
                    end
                
                end                
                    
            end
            
        end
        
    elseif (optionMain==2) %[Step 2] Capture tolerances ...
    
        optionMainCaptureSource=0;
        exitMainCaptureSource=4;
        
        while (optionMainCaptureSource~=exitMainCaptureSource)
            
            optionMainCaptureSource=menu('Capture source', 'From webcam', 'From video', 'From image', 'Return to Main menu');
                
            if (optionMainCaptureSource==1) %From webcam
                
                messageMainCaptureSourceWebcam='A possible future work line.';
                msgbox(messageMainCaptureSourceWebcam, 'Capture source: From webcam', 'help');
                
            elseif (optionMainCaptureSource==2) %From video              
                
                optionMainCaptureSourceVideo=0;
                exitMainCaptureSourceVideo=4;
                
                while (optionMainCaptureSourceVideo~=exitMainCaptureSourceVideo)
                
                    optionMainCaptureSourceVideo=menu('From video', 'IA04', '0863-012', '5828-001', 'Return to Capture source menu');
                    
                    if (optionMainCaptureSourceVideo==1)
                        
                        if (exist('IA04ProcessPiece.dat')==2)
                            if (exist('IA04PixelConversion.dat')==2)
                                
                                load('IA04ProcessPiece.dat', '-mat');
                                load('IA04PixelConversion.dat', '-mat');
                
                                [framesStructTolerancesObtained, framesStructProcessGenericPiece]=demandedTolerancesVideo('IA04', structProcessGenericPieceReference);
                                numFrames=length(framesStructTolerancesObtained);
                                
                                if (numFrames>0)
                                    framesNumber=insertVideoFramesNumberMenu('IA04', numFrames);
                                    while (framesNumber==Inf)
                                        framesNumber=insertVideoFramesNumberMenu('IA04', numFrames);
                                    end                                 
                                
                                    structTolerancesObtained=framesStructTolerancesObtained{framesNumber,1};
                                    showTolerancesIA04(structTolerancesObtained, milimetresNumber, true);
                                    showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                    isAcceptedTolerancesIA04(structTolerancesObtained, milimetresNumber);
                                    disp(' ');
                                end
                            
                                clear frameStructTolerancesObtained frameStructProcessGenericPiece;
                            
                            else
                            
                                messageMainCaptureSourceVideo='IA04 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... IA04';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');
                                
                            end
                        
                        else
                            
                            messageMainCaptureSourceVideo='IA04 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                            msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');                                
                            
                        end                              
                             
                    elseif (optionMainCaptureSourceVideo==2)
                        
                        if (exist('0863012ProcessPiece.dat')==2)
                            if (exist('0863012PixelConversion.dat')==2)
                                
                                load('0863012ProcessPiece.dat', '-mat');
                                load('0863012PixelConversion.dat', '-mat');
                        
                                [framesStructTolerancesObtained, framesStructProcessGenericPiece]=demandedTolerancesVideo('0863-012', structProcessGenericPieceReference);
                                numFrames=length(framesStructTolerancesObtained);
                                
                                if (numFrames>0)
                                    framesNumber=insertVideoFramesNumberMenu('0863-012', numFrames);
                                    while (framesNumber==Inf)
                                        framesNumber=insertVideoFramesNumberMenu('0863-012', numFrames);
                                    end                                 
                                
                                    structTolerancesObtained=framesStructTolerancesObtained{framesNumber,1};
                                    showTolerances0863012(structTolerancesObtained, milimetresNumber, true);
                                    showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                    isAcceptedTolerances0863012(structTolerancesObtained, milimetresNumber);
                                    disp(' ');
                                end
                            
                                clear frameStructTolerancesObtained frameStructProcessGenericPiece;
                                
                            else
                                
                                messageMainCaptureSourceVideo='0863-012 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');
                                
                            end
                                
                        else
                            
                            messageMainCaptureSourceVideo='0863-012 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                            msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');                            
                            
                        end
                        
                    elseif (optionMainCaptureSourceVideo==3)
                        
                        if (exist('5828001ProcessPiece.dat')==2)
                            if (exist('5828001PixelConversion.dat')==2)
                                
                                load('5828001ProcessPiece.dat', '-mat');
                                load('5828001PixelConversion.dat', '-mat');
                        
                                [framesStructTolerancesObtained, framesStructProcessGenericPiece]=demandedTolerancesVideo('5828-001', structProcessGenericPieceReference);
                                numFrames=length(framesStructTolerancesObtained);
                                
                                if (numFrames>0)
                                    framesNumber=insertVideoFramesNumberMenu('5828-001', numFrames);
                                    while (framesNumber==Inf)
                                        framesNumber=insertVideoFramesNumberMenu('5828-001', numFrames);
                                    end                                 
                                
                                    structTolerancesObtained=framesStructTolerancesObtained{framesNumber,1};
                                    showTolerances5828001(structTolerancesObtained, milimetresNumber, true);
                                    showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                    isAcceptedTolerances5828001(structTolerancesObtained, milimetresNumber);
                                    disp(' ');
                                end
                            
                                clear frameStructTolerancesObtained frameStructProcessGenericPiece;
                                
                            else
                                
                                messageMainCaptureSourceVideo='5828-001 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... 5828-001';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');
                                
                            end
                                
                        else
                            
                            messageMainCaptureSourceVideo='5828-001 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... 5828-001';
                            msgbox(messageMainCaptureSourceVideo, 'Capture source: From video', 'help');                            
                            
                        end                        
                            
                    end
                   
                end
                
            elseif (optionMainCaptureSource==3) %From image
                
                optionMainCaptureSourceImage=0;
                exitMainCaptureSourceImage=4;
                
                while (optionMainCaptureSourceImage~=exitMainCaptureSourceImage)
                    
                    optionMainCaptureSourceImage=menu('From image', 'IA04', '0863-012', '5828-001', 'Return to Capture source menu');
                    
                    if (optionMainCaptureSourceImage==1)
                        
                        if (exist('IA04ProcessPiece.dat')==2)
                            if (exist('IA04PixelConversion.dat')==2)
                                
                                load('IA04ProcessPiece.dat', '-mat');
                                load('IA04PixelConversion.dat', '-mat');
                                
                                [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances('IA04', structProcessGenericPieceReference);
                                showGenericPiece(structProcessGenericPiece, milimetresNumber, true);
                                showTolerancesIA04(structTolerancesObtained, milimetresNumber, true);
                                showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                isAcceptedTolerancesIA04(structTolerancesObtained, milimetresNumber);
                                disp(' ');
                                clear structTolerancesObtained structProcessGenericPiece;
                                
                            else
                                
                                messageMainCaptureSourceVideo='0863-012 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From image', 'help');
                                
                            end                                
                            
                        else
                            
                            messageMainCaptureSourceImage='IA04 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... IA04';
                            msgbox(messageMainCaptureSourceImage, 'Capture source: From image', 'help');                            
                            
                        end    
                
                    elseif (optionMainCaptureSourceImage==2)
                        
                        if (exist('0863012ProcessPiece.dat')==2)
                            if (exist('0863012PixelConversion.dat')==2)
                                
                                load('0863012ProcessPiece.dat', '-mat');
                                load('0863012PixelConversion.dat', '-mat');                                
                        
                                [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances('0863-012', structProcessGenericPieceReference);
                                showGenericPiece(structProcessGenericPiece, milimetresNumber, true);
                                showTolerances0863012(structTolerancesObtained, milimetresNumber, true);
                                showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                isAcceptedTolerances0863012(structTolerancesObtained, milimetresNumber);
                                disp(' ');
                                clear structTolerancesObtained structProcessGenericPiece;
                                
                            else
                                
                                messageMainCaptureSourceVideo='0863-012 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From image', 'help');
                                
                            end                                
                            
                        else
                            
                            messageMainCaptureSourceImage='0863-012 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... 0863-012';
                            msgbox(messageMainCaptureSourceImage, 'Capture source: From image', 'help');
                            
                        end
                        
                    elseif (optionMainCaptureSourceImage==3)
                        
                        if (exist('5828001ProcessPiece.dat')==2)
                            if (exist('5828001PixelConversion.dat')==2)
                                
                                load('5828001ProcessPiece.dat', '-mat');
                                load('5828001PixelConversion.dat', '-mat');                                
                        
                                [structTolerancesObtained, structProcessGenericPiece]=demandedTolerances('5828-001', structProcessGenericPieceReference);
                                showGenericPiece(structProcessGenericPiece, milimetresNumber, true);
                                showTolerances5828001(structTolerancesObtained, milimetresNumber, true);
                                showAnalyzeContourPointsDistances(structTolerancesObtained, milimetresNumber);
                                isAcceptedTolerances5828001(structTolerancesObtained, milimetresNumber);
                                disp(' ');
                                clear structTolerancesObtained structProcessGenericPiece;
                                
                            else
                                
                                messageMainCaptureSourceVideo='5828-001 pixel conversion database not found. See [Step 1] Reference image pieces (0 defaults) ... 5828-001';
                                msgbox(messageMainCaptureSourceVideo, 'Capture source: From image', 'help');
                                
                            end                                
                            
                        else
                            
                            messageMainCaptureSourceImage='5828-001 process piece not found. See [Step 1] Reference image pieces (0 defaults) ... 5828-001';
                            msgbox(messageMainCaptureSourceImage, 'Capture source: From image', 'help');
                            
                        end                        
                        
                    end
                    
                end
                
            end
            
        end
        
    elseif (optionMain==3) %Learn about application ...
        
        close all;
        helpwin explanationControlMechanicalPieces;
        
        imageReference=imread('Reference5828-001.png');
        imageReference=screenDisplayingAtScale(imageReference, [0.8 0.8]);
        figure('Name', 'Image Piece: Reference 5828-001');
        imshow(imageReference);
        
        imageReference=imread('Reference0863-012.png');
        imageReference=screenDisplayingAtScale(imageReference, [1 1]);
        figure('Name', 'Image Piece: Reference 0863-012'); 
        imshow(imageReference);        
        
        imageReference=imread('ReferenceIA04.png');
        imageReference=screenDisplayingAtScale(imageReference, [1 1]);
        figure('Name', 'Image Piece: Reference IA04');
        imshow(imageReference);        
        
        clear imageReference;
        
    elseif (optionMain==4) %Within the framework of Pro2Control ...
        
        close all;
        web http://www.pro2control.net/objectives.asp;
        
    end    
        
end
                