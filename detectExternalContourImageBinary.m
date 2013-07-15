function infoPointsBinaryExternalContour=detectExternalContourImageBinary(pImageBinary)

    dimension=size(pImageBinary);
    imageBinaryExternalContour=zeros(dimension);
    
    for i=1:1:dimension(1)
        j=1;
        detectedExternalContour=false;
        while (detectedExternalContour==false)&&(j<=dimension(2))
            if (pImageBinary(i,j)==1)
                detectedExternalContour=true;
                imageBinaryExternalContour(i,j)=imageBinaryExternalContour(i,j)+1;
            else
                j=j+1;
            end
        end
        
        j=dimension(2);
        detectedExternalContour=false;
        while (detectedExternalContour==false)&&(j>0)
            if (pImageBinary(i,j)==1)
                detectedExternalContour=true;
                imageBinaryExternalContour(i,j)=imageBinaryExternalContour(i,j)+1;
            else
                j=j-1;
            end
        end
    end
    
    for j=1:1:dimension(2)
        i=1;
        detectedExternalContour=false;
        while (detectedExternalContour==false)&&(i<=dimension(1))
            if (pImageBinary(i,j)==1)
                detectedExternalContour=true;
                imageBinaryExternalContour(i,j)=imageBinaryExternalContour(i,j)+1;
            else
                i=i+1;
            end
        end
        
        i=dimension(1);
        detectedExternalContour=false;
        while (detectedExternalContour==false)&&(i>0)
            if (pImageBinary(i,j)==1)
                detectedExternalContour=true;
                imageBinaryExternalContour(i,j)=imageBinaryExternalContour(i,j)+1;
            else
                i=i-1;
            end
        end
    end
    
    imageBinaryExternalContour=imageBinaryExternalContour==2;
    imageBinaryExternalContour=bwareaopen(imageBinaryExternalContour,2);
    
    indexInfoPointsBinaryExternalContour=1;
    
    for i=1:1:dimension(1)
        for j=1:1:dimension(2)
            if (pImageBinary(i,j)==1)
                infoPointsBinaryExternalContour(indexInfoPointsBinaryExternalContour,1)=i;
                infoPointsBinaryExternalContour(indexInfoPointsBinaryExternalContour,2)=j;
                indexInfoPointsBinaryExternalContour=indexInfoPointsBinaryExternalContour+1;
            end
        end
    end
    
end
