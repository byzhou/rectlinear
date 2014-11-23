sizeX       = rectx.size () ;
sizeY       = recty.size () ;

% Push all the elements in the queue to quit to write result vector
for i = 1 : sizeX
    writeResult ( 2 * i - 1 ) = rectx.remove () ;
    writeResult ( 2 * i )     = recty.remove () ;
end