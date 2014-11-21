load saveData
plotx = ones ( rectx.size() , 1 ) ;
ploty = ones ( recty.size() , 1 ) ;

for i = 1 : rectx.size() 
    plotx ( i ) = rectx.remove () ;
    ploty ( i ) = recty.remove () ;
end

figure ( 1 ) ;
plot ( plotx , ploty ) ;

%%
plotx = ones ( length ( poly ) / 2 , 1 ) ;
ploty = ones ( length ( poly ) / 2 , 1 ) ;

j = 1 ;
k = 1 ;
for i = 1 : length (poly) 
    if ( mod ( i , 2 ) == 1 )
        plotx ( j ) = poly ( i ) ;
        j = j + 1 ;
    else
        ploty ( k ) = poly ( i ) ;
        k = k + 1 ;
    end
end

figure ( 2 ) ;
plot ( plotx , ploty ) ;
grid ;