function outputImage=bresenhamDiscontinuousLine(inputImage, x1, y1, x2, y2)

   %calculation of the increases for the case diagonal section (dxd,dyd)
   
   dx=1;
   dy=1;
   incy=y2-y1;
   
   if (incy<0)
       dy=-dy;
       incy=-incy;
   end
   
   dyd=dy;
   incx=x2-x1;
   
   if (incx<0)
       dx=-dx;
       incx=-incx;
   end
   
   dxd=dx;
   
   %calculation of the increases for the case straight section (dxr,dyr)
   
   if (incx>=incy)
       dy=0;
   else
       dx=0;
       x=incx;
       incx=incy;
       incy=x;
   end
   
   dyr=dy;
   dxr=dx;
   
   %initial values
   
   x=x1;
   y=y1;
   outputImage=inputImage;
   
   Er=2*incy;
   Ed=2*incy-2*incx;
   E=2*incy-incx;
   
   i=0;
   
   while (i<(incx-1))
       if (E>=0)
           x=x+dxd;
           y=y+dyd;
           E=E+Ed;
       else
           x=x+dxr;
           y=y+dyr;
           E=E+Er;
       end
       
       if (mod(sum([x y]),2)~=0)
           outputImage(x,y)=1;
       end
       
       i=i+1;
      
   end

end
