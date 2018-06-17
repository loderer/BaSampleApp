function startup()
    % Add required directories to classpath. 
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaMatlab\jfx4matlabAdapter'));
    addpath(genpath('C:\Users\rudi\Documents\GitHub\BaSampleApp'))
    
    model = Model();
    
    jfxApplicationAdapter = JFXApplicationAdapter('jfx_4_matlab.JFXApplication');
    overviewStageController = JFXStageController('Phone book', jfxApplicationAdapter);
    overviewSceneController = OverviewController(strcat(Config.rootPath, '\scenes\overview\overview.fxml'), model);
    overviewStageController.showScene(overviewSceneController);