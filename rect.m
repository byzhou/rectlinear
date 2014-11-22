
clear ;
% The polygon that I am working on
poly=[0 -0.085 1.14 -0.085 1.14 0.085 1.07 0.085 1.07 0.195 1 0.195 1 0.085 ...
0.485 0.085 0.485 0.275 0.415 0.275 0.415 0.085 0.11 0.085 0.11 0.275 0.04 ...
0.275 0.04 0.085 0 0.085];

% initialization
xcoords = java.util.LinkedList () ;
ycoords = java.util.LinkedList () ;
xtmp    = ones ( 3 , 1 ) ;
ytmp    = ones ( 3 , 1 ) ;
rectx   = java.util.LinkedList ();
recty   = java.util.LinkedList ();

% unroll to x and y coordinates
for i = 1 : length (poly) 
    if ( mod ( i , 2 ) == 1 )
        xcoords.add(poly(i)) ;
    else
        ycoords.add(poly(i)) ;
    end
end

fullcover       = false ;
while ( xcoords.size () > 4 ) & ( fullcover == false )
    for i = 1 : 3
        xtmp(i) = xcoords.remove () ;
        ytmp(i) = ycoords.remove () ;
    end
    
    
    sizeX = xcoords.size() ;
    sizeY = ycoords.size() ;

    overlap         = true ;     
    followPattern   = false ;
    % Roll forward until the typical four kinds of pattern have been
    % followed and make sure that there is no overlapping issues
    fullcover       = false ;
    while ( followPattern == false | overlap == true ) & ( fullcover == false )
        overlap = false ;
        if rectx.size() > 4 
            sizeX  = rectx.size () ;
            sizeY  = recty.size () ;
            % ensure there is no points form points pool in a rectangle
            for i = 1 : ( sizeX ) / 4
                x1 = rectx.remove () ;
                y1 = recty.remove () ;
                x2 = rectx.remove () ;
                y2 = recty.remove () ;
                x3 = rectx.remove () ;
                y3 = recty.remove () ;
                x4 = rectx.remove () ;
                y4 = recty.remove () ;
                [tmpx4 tmpy4] = x4y4 ( xtmp ( 1 ) , ytmp ( 1 ) , xtmp ( 2 ) , ...
                ytmp ( 2 ) , xtmp ( 3 ) , ytmp ( 3 ) ) ;
                overlap = inrect ( [tmpx4 tmpy4] , x1 , y1 , x2 , y2 , ...
                x3 , y3 , x4 , y4 ) | overlap ;
                rectx.add ( x1 ) ;
                recty.add ( y1 ) ;
                rectx.add ( x2 ) ;
                recty.add ( y2 ) ;
                rectx.add ( x3 ) ;
                recty.add ( y3 ) ;
                rectx.add ( x4 ) ;
                recty.add ( y4 ) ;
            end
            
            % ensure existing points are not in the generated rectangle
            if ~overlap
                sizeX = xcoords.size () ;
                sizeY = ycoords.size () ;
                for i = 1 : ( sizeX ) 
                    x1 = xcoords.remove () ;
                    y1 = ycoords.remove () ;
                    [x4 y4] = x4y4 ( xtmp ( 1 ) , ytmp ( 1 ) ,...
                                     xtmp ( 2 ) , ytmp ( 2 ) ,...
                                     xtmp ( 3 ) , ytmp ( 3 ) ) ;
                    overlap = inrect ( [x1 y1] , ...
                    xtmp ( 1 ) , ytmp ( 1 ) , xtmp ( 2 ) , ytmp ( 2 ) , ...
                    xtmp ( 3 ) , ytmp ( 3 ) , x4 , y4 ) ;
                    xcoords.add ( x1 ) ;
                    ycoords.add ( y1 ) ;
                end  
            end
        end
               
        % Outer bounds of a rectangular has been found
        if ( ( ( xtmp ( 1 ) == xtmp ( 2 ) ) & ( ytmp ( 2 ) > ytmp ( 1 ) ) ...
            & ( xtmp ( 3 ) < xtmp ( 2 ) ) ) | ...
           ( ( ytmp ( 1 ) == ytmp ( 2 ) ) & ( xtmp ( 2 ) > xtmp ( 1 ) ) ...
            & ( ytmp ( 3 ) > ytmp ( 2 ) ) ) | ...
           ( ( xtmp ( 1 ) == xtmp ( 2 ) ) & ( ytmp ( 2 ) < ytmp ( 1 ) ) ...
            & ( xtmp ( 3 ) > xtmp ( 2 ) ) ) | ...
           ( ( ytmp ( 1 ) == ytmp ( 2 ) ) & ( xtmp ( 2 ) < xtmp ( 1 ) ) ...
            & ( ytmp ( 3 ) < ytmp ( 2 ) ) ) )
            % The similar pattern has followed
            followPattern = true ;
            % Calculate the fourth point
            [x4 y4] = x4y4 ( xtmp ( 1 ) , ytmp ( 1 ) , xtmp ( 2 ) , ytmp ( 2 ) ,...
                             xtmp ( 3 ) , ytmp ( 3 ) ) ;
            x1  = xtmp ( 1 ) ;
            y1  = ytmp ( 1 ) ;
            x2  = xtmp ( 2 ) ;
            y2  = ytmp ( 2 ) ;
            x3  = xtmp ( 3 ) ;
            y3  = ytmp ( 3 ) ;
            rectx.add ( x1 ) ;
            recty.add ( y1 ) ;
            rectx.add ( x2 ) ;
            recty.add ( y2 ) ;
            rectx.add ( x3 ) ;
            recty.add ( y3 ) ;
            rectx.add ( x4 ) ;
            recty.add ( y4 ) ;
            
        end
            
        if followPattern == false | overlap == true 
            % Outer bounds pattern does not satisfy, so roll forward
            xcoords.add ( xtmp ( 1 ) ) ;
            ycoords.add ( ytmp ( 1 ) ) ;
            xtmp ( 1 ) = xtmp ( 2 ) ;
            ytmp ( 1 ) = ytmp ( 2 ) ;
            xtmp ( 2 ) = xtmp ( 3 ) ;
            ytmp ( 2 ) = ytmp ( 3 ) ;
            xtmp ( 3 ) = xcoords.remove () ;
            ytmp ( 3 ) = ycoords.remove () ;
            Plots ;
        elseif followPattern == true & overlap == false 
            % Store the first and fourth points into the original point pool
            xcoords.add ( x1 ) ;
            ycoords.add ( y1 ) ;
            % Check whether the fourth point is in the point pool
            inlib = false ;
            
            sizeX = xcoords.size() ;
            sizeY = ycoords.size() ;
            
            k = 0 ;
            for i = 1 : sizeX 
                k = k + 1 ;
                xcout = xcoords.remove() ;
                ycout = ycoords.remove() ;
                if ( x4 == xcout ) & ( y4 == ycout )
                    inlib = true ;
                end
                xcoords.add(xcout);
                ycoords.add(ycout);
            end
            if inlib == false
                xcoords.add(x4);
                ycoords.add(y4);
            end
            Plots ;
        end
        Plots ;
        save forfullcoverTest ;
        fullcoverTest ;
    end
end

if fullcover == 0 
    rectx.add(xcoords.remove());
    recty.add(ycoords.remove());
    rectx.add(xcoords.remove());
    recty.add(ycoords.remove());
    rectx.add(xcoords.remove());
    recty.add(ycoords.remove());
    rectx.add(xcoords.remove());
    recty.add(ycoords.remove());
end

save saveData