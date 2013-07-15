function distance=plannerDistance(pPointOne, pPointTwo)

    x0=pPointOne(1);
    y0=pPointOne(2);
    x1=pPointTwo(1);
    y1=pPointTwo(2);

    distance=sqrt((x1-x0).^2 + (y1-y0).^2);
    
end
