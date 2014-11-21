fullcover = true ;

for k = 1 : rectx.size() / 4
    for i = 1 : 4
        xremain ( i )      = rectx.remove() ;
        rectx.add ( xremain ( i ) ) ;
    end
    xmin    = min ( xremain ) ;
    xmax    = max ( xremain ) ;

    for i = 1 : 4
        yremain ( i )      = recty.remove() ;
        recty.add ( yremain ( i ) ) ;
    end
    ymin    = min ( yremain ) ;
    ymax    = max ( yremain ) ;

    tmpx    = ones ( xcoords.size () , 1 ) ;
    tmpy    = ones ( ycoords.size () , 1 ) ;

    sizeX   = xcoords.size () ;
    sizeY   = ycoords.size () ;

    % set tmp value from the coords
    for i = 1 : sizeX
        tmpx ( i ) = xcoords.remove () ;
        tmpy ( i ) = ycoords.remove () ;
        xcoords.add ( tmpx ( i ) ) ;
        ycoords.add ( tmpy ( i ) ) ;
    end

    % try to see whether tmp values are within cirtain range
    for i = 1 : sizeX
        if ~( ( tmpx ( i ) >= xmin ) ...
           & ( tmpx ( i ) <= xmax ) ...
           & ( tmpy ( i ) >= ymin ) ...
           & ( tmpy ( i ) <= ymax ) )
            fullcover = false ;
        end
    end
end

        

