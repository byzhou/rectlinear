% reset
clear ;

% open directory
listing         = dir ( 'lef' ) ;
j               = 1 ;
sizeoflisting   = size ( listing ) ;

% store all the file name 
for i = 1 : sizeoflisting ( 1 )
    str             = listing ( i ) . name ; 
    tmpFName        = regexp ( str , '\w*(?=\.lef)' , 'match' ) ;
    %tmpFName        = regexp ( str , '(?<=INV).*' , 'match' ) ;
    
    if  ~isempty ( tmpFName ) 
        fileName ( j )  = tmpFName ;
        j               = j + 1 ;
    end
end

save readFromFile ;

%% read in the file 
sizeofNames     = size ( fileName ) ;
for i = 1 : sizeofNames ( 2 ) 
    readName        = char ( strcat ( 'lef/' , fileName ( i ) , '.lef' ) );
    writeName       = char ( strcat ( 'txt/' , fileName ( i ) , '.txt' ) );
    fReadID         = fopen  ( readName , 'r' ) ;
    fWriteID        = fopen  ( writeName , 'w' ) ;
    
    % open read file
    if ( fReadID == -1 )
        fprintf ( 'ERROR: Cannot open %s to read !\n' , readName ) ;
    else
        fprintf ( '%s has been opened successfully!\n' , readName ) ;
    end
    
    % open write file
    if ( fWriteID == -1 )
        fprintf ( 'ERROR: Cannot open %s to read !\n' , writeName ) ;
    else
        fprintf ( '%s has been opened successfully!\n' , writeName ) ;
    end
    
    % scan over the file and search for polygon
    line_f_pre      = fgetl ( fReadID ) ;
    while ( ~feof ( fReadID ) ) 
        
        line_f          = fgetl ( fReadID ) ;
        % regular expression found the string with polygon and then push to
        % a string and then convert string to double vector
        polyreadin      = strread ( cell2mat ( regexp ( line_f , ...
                            '(?<=POLYGON).*(?=;)' , 'match' ) ) ) ;
        polyreadin_pre  = strread ( cell2mat ( regexp ( line_f_pre , ...
                            '(?<=POLYGON).*(?=;)' , 'match' ) ) ) ;
        
        % if polygon series is too long and it contains two consecutive
        % lines, the two lines will be concatenate together, otherwise we
        % only check the last line. This prevent read in twice because of
        % two consecutive lines
        if ~isempty ( polyreadin_pre ) & ~isempty ( polyreadin ) 
            poly    = cat ( 2 , polyreadin_pre , polyreadin ) ;
            % executing formating
            % rect ;
        elseif ~isempty ( polyreadin_pre )
            poly    = polyreadin_pre ;            
        end
        
        line_f_pre  = line_f ; 
    end
    
    % close the files
    fclose ( fReadID ) ;
    fclose ( fWriteID ) ;
end

%%Save data
save readFromFile ;

    

