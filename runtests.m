function runtests()
    %--------------------------------------------------------------------------    
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    % Add MATLAB-library to class path. 
    addpath('C:\Users\rudi\Documents\GitHub\jfx4matlab');
    import jfx4matlab.matlab.*;
    %--------------------------------------------------------------------------    
    
    detailTest = DetailTest(); 
    detailTest.run