%detect contours
function [startx stopx starty stopy contour] = findContours(BW, mapping);

    [m n] = size(BW);

     flag=0, r=0, c=0;
     for(i=1:m)
         for(j=1:n)
             if(BW(i,j)==1)
                 r=i;
                 c=j;
                 flag=1;
                 break;
             end
         end
         if(flag==1)
             break;
         end
     end

     contour = bwtraceboundary(BW,[r c],'E',4,Inf,'counterclockwise');
     [s1 s2] = size(contour);
     for(i=1:s1)
        contour(i,2) = contour(i,2) + mapping(1,1) - 2;
        contour(i,1) = contour(i,1) + mapping(1,2) - 2;
     end

     startx = contour(1,2);
     stopx = contour(1,2);
     for(i=1:s1)
         if(startx > contour(i,2))
             startx = contour(i,2);
             starty = contour(i,1);
         end
         if(stopx < contour(i,2))
             stopx = contour(i,2);
             stopy = contour(i,1);
         end
     end
 end