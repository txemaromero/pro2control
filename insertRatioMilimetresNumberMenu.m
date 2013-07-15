function milimetresNumber=insertRatioMilimetresNumberMenu(pNamePieceReference)

    milimetresNumber=Inf;
                    
    prompt='The number must be a positive <= 1.8';
    title='1 pixel per (unknown) milimetres';
    lines=1;
    def={'0.0457'};
    answer=inputdlg(prompt, title, lines, def);
    parameter=double(str2num(char(answer)));
    
    if (size(parameter, 1)~=0)
        milimetresNumber=parameter(1);
        if (milimetresNumber<=0)||(milimetresNumber>1.8)||(~isa(milimetresNumber, 'double'))
            milimetresNumber=Inf;
            warndlg(prompt, ' Insert the number of milimetres ');
        else
            msgbox(strcat(pNamePieceReference, ': 1 pixel per ', num2str(milimetresNumber), ' milimetres.'), 'Number of milimetres', 'help');
        end
    end
    
end
