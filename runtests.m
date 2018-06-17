function runtests()
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaMatlab\jfx4matlabAdapter'));
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    
    detailTest = DetailTest(); 
    detailTest.run