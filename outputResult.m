sizeX       = rectx.size () ;
sizeY       = recty.size () ;

% Push all the elements in the queue to quit to write result vector
for i = 1 : sizeX / 4
    for j = 1 : 4 
        writeResult ( i , ( 2 * j - 1 ) ) = rectx.remove () ;
        writeResult ( i , ( 2 * j ) )     = recty.remove () ;
    end
end
