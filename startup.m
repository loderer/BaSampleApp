function startup()
    % Benötigte Klassen zum statischen Klassenpfad hinzufügen
    % add extern libraries
    addpath('C:\Users\rudi\Documents\GitHub\jsonlab');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\extLib');
    addpath('C:\Users\rudi\Documents\GitHub\BaMatlab\jfx4matlabAdapter');
    javaaddpathstatic(['C:\Program Files\MATLAB\R2015b\sys\java\jre\win64\jre\lib\jfxrt.jar']);
    javaaddpathstatic(['C:\Users\rudi\Documents\GitHub\BaJavaFx\out\artifacts\jfx4matlab_jar\jfx4matlab.jar']);
    % add source folders
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\scenes\detail');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\scenes\dialog');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\scenes\overview');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\scenes\overviewList');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\scenes\plot');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\model');
    addpath('C:\Users\rudi\Documents\GitHub\BaSampleApp\model\person');
    
    model = Model();
    
    jfxApplicationAdapter = JFXApplicationAdapter('jfx_4_matlab.JFXApplication');
    overviewStageController = JFXStageController('Phone book', jfxApplicationAdapter);
    overviewSceneController = OverviewController(strcat(Config.root, '\scenes\overview\overview.fxml'), model);
    overviewStageController.showScene(overviewSceneController, 800, 500);