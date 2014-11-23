load forfullcoverTest ;
fullcover = true ;
% set tmp value from the coords
tmpx    = ones ( xcoords.size () , 1 ) ;
tmpy    = ones ( ycoords.size () , 1 ) ;

sizeX   = xcoords.size () + 3 ;
sizeY   = ycoords.size () + 3 ;

regcover= ones ( sizeX , 1 ) ;

for i = 1 : ( sizeX - 3 )
    tmpx ( i )      = xcoords.remove () ;
    tmpy ( i )      = ycoords.remove () ;
    regcover ( i )  = false ;
    xcoords.add ( tmpx ( i ) ) ;
    ycoords.add ( tmpy ( i ) ) ;
end

for j = 1 : 3
    tmpx ( i + j ) = xtmp ( j ) ;
    tmpy ( i + j ) = ytmp ( j ) ;
    regcover ( i + j ) = false ;
end    

for k = 1 : rectx.size() / 4
    for i = 1 : 4
        xremain ( i ) = rectx.remove() ;
        rectx.add ( xremain ( i ) ) ;
    end
    xmin    = min ( xremain ) ;
    xmax    = max ( xremain ) ;

    for i = 1 : 4
        yremain ( i ) = recty.remove() ;
        recty.add ( yremain ( i ) ) ;
    end
    ymin    = min ( yremain ) ;
    ymax    = max ( yremain ) ;

    % try to see whether tmp values are within cirtain range
    for i = 1 : sizeX
        if ( ( tmpx ( i ) >= xmin ) ...
           & ( tmpx ( i ) <= xmax ) ...
           & ( tmpy ( i ) >= ymin ) ...
           & ( tmpy ( i ) <= ymax ) )
            regcover ( i ) = true ;
        end
    end    
end

for i = 1 : sizeX
    if ( regcover ( i ) == false )
        fullcover = false ;
        %fprintf ( 'The outer points are \n' ) ;
        %fprintf ( 'x %f y %f \n' , tmpx ( i ) , tmpy ( i ) ) ;
    end
end

sizeX   = xcoords.size () ;
sizeY   = ycoords.size () ;
for i = 1 : length ( regcover ) 
    if regcover ( i ) == true
        for j = 1 : sizeX 
            myy = xcoords.remove () ;
            myx = ycoords.remove () ;
            if myx ~= tmpx ( i ) | myy ~= tmpy ( i ) 
                xcoords.add ( myx ) ;
                ycoords.add ( myy ) ;
            end
        end
    end
end
