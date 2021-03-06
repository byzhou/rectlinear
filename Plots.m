
plotx = ones ( length ( poly ) / 2 , 1 ) ;
ploty = ones ( length ( poly ) / 2 , 1 ) ;

for i = 1 : rectx.size() 
    plotx ( i ) = rectx.remove () ;
    ploty ( i ) = recty.remove () ;
    rectx.add ( plotx ( i ) ) ;
    recty.add ( ploty ( i ) ) ;
end

plot ( plotx , ploty , ...
        xtmp ( 1 ) , ytmp ( 1 ) , 'o' , ...
        xtmp ( 2 ) , ytmp ( 2 ) , '*' , ...
        xtmp ( 3 ) , ytmp ( 3 ) , '+' ) ;
grid ;
