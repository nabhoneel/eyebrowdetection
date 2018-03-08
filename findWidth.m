%find width of eyebrow
function width = findWidth(contour);
    MAX = max(contour);
    MIN = min(contour);
    
    y = (MAX(1) + MIN(1)) / 2;
    
    [s1 s2] = size(contour);
    distance = 0;
    for(i=1:s1)
        if(contour(i,1) < y)
            for(j=1:s1)
                if(contour(j,1) > y && contour(i,2) == contour(j,2))
                    if(distance < (contour(j,1) - contour(i,1)))
                        distance = contour(j,1) - contour(i,1);
                        disp('Distance: ' + distance);
                    end
                end
            end
        end
    end
    width = distance;
end