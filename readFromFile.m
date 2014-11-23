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

%h = waitbar(0,'Initializing waitbar...');
sizeofNames     = size ( fileName ) ;
for i = 1 : sizeofNames ( 2 ) 
    
    % Progress Bar
    %perc            = ( i - 1 ) / sizeofNames ( 2 ) * 10 ;
    %waitbar ( perc/100 , h , sprintf ( '%3.2f%% along...' , perc ) ) ;
    
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
        % regular expression found the string with polygon 
        polyreadin      = regexp ( line_f , '(?<=POLYGON).*(?=;)' , ...
                            'match' ) ;
        polyreadin_pre  = regexp ( line_f_pre , '(?<=POLYGON).*(?=;)' ,...
                            'match' ) ;
        
        % if polygon series is too long and it contains two consecutive
        % lines, the two lines will be concatenate together, otherwise we
        % only check the last line. This prevent read in twice because of
        % two consecutive lines
        if ~isempty ( polyreadin_pre ) & ~isempty ( polyreadin ) 
            
            % Reformating: convert cell to string and then convert string
            % to vector
            polyreadin_post      = strread ( cell2mat ( polyreadin ) ) ;
            polyreadin_pre_post  = strread ( cell2mat ( polyreadin_pre ) ) ;
            
            poly_post            = cat ( 2 , polyreadin_pre_post ,...
                                polyreadin_post ) ;
            poly                 = poly_post ( 1 : end - 1 ) ;
            % executing formating
            rect ;
            fprintf ( fWriteID , ...
                        [repmat('%f ', 1, size(writeResult, 2)) '\n'], ...
                        writeResult') ;
            % Different structure spliter.
            fprintf ( fWriteID , '\n' ) ;
        elseif ~isempty ( polyreadin_pre )
            polyreadin_pre_post  = strread ( cell2mat ( polyreadin_pre ) ) ;            
            poly_post            = polyreadin_pre_post ; 
            poly                 = poly_post ( 1 : end - 1 ) ;
            % executing formating
            save fordebug ;
            rect ;
            fprintf ( fWriteID , ...
                        [repmat('%f ', 1, size(writeResult, 2)) '\n'], ...
                        writeResult') ;
            % Different structure spliter.
            fprintf ( fWriteID , '\n' ) ;
        end
        % This is for polygon with two lines
        line_f_pre  = line_f ; 
    end
    
    % close the files    
    if ( fclose ( fReadID ) == 0)
        fprintf ('File %s has been read successfuly!\n', readName ) ;
    else
        fprintf ('ERROR: Cannot close file %s! Now exiting\n', readName ) ;
        return;
    end
    
    if ( fclose ( fWriteID ) == 0)
        fprintf ('File %s has been written successfuly!\n', writeName ) ;
    else
        fprintf ('ERROR: Cannot close file %s! Now exiting\n', writeName ) ;
        return;
    end
    
end

%%Save data
save readFromFile ;
%close(h);

