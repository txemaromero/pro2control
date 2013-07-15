function framesNumber=insertVideoFramesNumberMenu(pNamePieceReference, pNumFrames)

    framesNumber=Inf;
                    
    prompt=strcat('Which frame do you want to obtain its tolerances?. The number must be a positive <= ', num2str(pNumFrames), '.');
    title=strcat('Number of frames (video): [1-', num2str(pNumFrames), ']');
    lines=1;
    def={'0'};
    answer=inputdlg(prompt, title, lines, def);
    parameter=double(str2num(char(answer)));
    
    if (size(parameter, 1)~=0)
        framesNumber=parameter(1);
        if (framesNumber<=0)||(framesNumber>pNumFrames)||(floor(framesNumber)~=framesNumber)||(~isa(framesNumber, 'double'))
            framesNumber=Inf;
            warndlg('The number of frames is not valid.' , ' Try again ');
        else
            msgbox(strcat(num2str(pNamePieceReference), ' video. (', num2str(framesNumber), ') frame selected.'), 'Tolerances', 'help');
        end
    end    
    
end
