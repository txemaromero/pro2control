function manipulationVideoSequences(pNamePiece, pNumPieces)
    
    for i=1:pNumPieces
        [aux,map]=imread(cat(2, pNamePiece, '-', num2str(i,'%2d'), '.jpg'));
        videoSequences(i)=im2frame(aux, map);
    end
    
    nameVideo=strcat('video', pNamePiece);
    movie2avi(videoSequences, nameVideo, 'compression', 'None');
    
    aviinfo(nameVideo)
    video=aviread(nameVideo);
    imshow(video(1).cdata);
    movie(video);
    
end
