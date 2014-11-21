function y = inrect ( tmp , x1 , y1 , x2 , y2 , x3 , y3 , x4 , y4 )
xtmp = tmp (1) ;
ytmp = tmp (2) ;
xlib = [x1 x2 x3 x4] ;
ylib = [y1 y2 y3 y4] ;
if ( ( xtmp > min ( xlib ) ) ...
    & ( xtmp < max ( xlib ) ) ...
    & ( ytmp > min ( ylib ) ) ...
    & ( ytmp < max ( ylib ) ) )
    y = true ;
else
    y = false ;
end
