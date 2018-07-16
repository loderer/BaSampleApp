function startup()
    %--------------------------------------------------------------------------    
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    % Add MATLAB-library to class path. 
    addpath('C:\Users\rudi\Documents\GitHub\jfx4matlab');
    import jfx4matlab.matlab.*;
    %--------------------------------------------------------------------------
    model = Model();
    
    jfxApplication = jfx4matlab.matlab.JFXApplication();
    overviewStageController = jfx4matlab.matlab.JFXStageController(jfxApplication, 'Phone book');
    overviewStageController.setIcon('C:\Users\rudi\Documents\GitHub\BaSampleApp\resources\sampleIcon.png');
    
    overviewSceneController = OverviewController(strcat(Config.rootPath, '\scenes\overview\overview.fxml'), model);
    overviewStageController.showScene(overviewSceneController);