function startup()
    %--------------------------------------------------------------------------    
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    % Add MATLAB-library to class path. 
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab');
    import jfx4matlab.matlab.*;
    %--------------------------------------------------------------------------
    model = Model();
    
    jfxApplicationAdapter = jfx4matlab.matlab.JFXApplicationAdapter();
    overviewStageController = jfx4matlab.matlab.JFXStageController(jfxApplicationAdapter, 'Phone book');
    overviewStageController.setIcon('C:\Users\rudi\Documents\GitHub\BaSampleApp\resources\sampleIcon.png');
    
    overviewSceneController = OverviewController(strcat(Config.rootPath, '\scenes\overview\overview.fxml'), model);
    overviewStageController.showScene(overviewSceneController);