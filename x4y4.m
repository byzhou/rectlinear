function [x4 y4] = x4y4 ( x1 , y1 , x2 , y2 , x3 , y3 )
if ( x1 == x2 ) & ( y2 == y3 )
    x4 = x3 ;
    y4 = y1 ;
elseif ( x1 == x2 & y1 == y3 )
    x4 = x3 ;
    y4 = y2 ;
elseif ( x1 == x3 & y1 == y2 )
    x4 = x2 ;
    y4 = y3 ;
elseif ( x1 == x3 & y3 == y2 )
    x4 = x2 ;
    y4 = y1 ;
elseif ( x2 == x3 & y1 == y2 )
    x4 = x1 ;
    y4 = y3 ;
elseif ( x2 == x3 & y1 == y3 )
    x4 = x1 ;
    y4 = y2 ;
else
    fprintf ( 'x1 %d y1 %d x2 %d y2 %d x3 %d y3 %d \n' , ...
                x1 , y1 , x2 , y2 , x3 , y3 ) ;
    x4 = 10000 ;
    y4 = 10000 ;
    fprintf ( ' There is no valid output.\n ' ) ;
end

