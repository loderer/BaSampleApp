function startup()
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaMatlab\jfx4matlabAdapter'));
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    
    model = Model();
    
    jfxApplicationAdapter = JFXApplicationAdapter();
    overviewStageController = JFXStageController(jfxApplicationAdapter, 'Phone book');
    overviewSceneController = OverviewController(strcat(Config.rootPath, '\scenes\overview\overview.fxml'), model);
    overviewStageController.showScene(overviewSceneController);