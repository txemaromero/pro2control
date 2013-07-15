function outputImage=screenDisplayingAtScale(pImage, pScale)

    dimension=size(pImage);
    outputImage=imresize(pImage,[pScale(1)*dimension(1) pScale(2)*dimension(2)],'nearest');
    
end
