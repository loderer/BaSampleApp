classdef DialogController < jfx4matlab.matlab.JFXSceneController
    %DialogController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        detailController; 
    end
    
    methods
        function obj = DialogController(fxml, detailController)
            obj = obj@jfx4matlab.matlab.JFXSceneController(fxml);
            obj.detailController = detailController;
        end
    end
    
    methods (Access = {?jfx4matlab.matlab.JFXSceneController})    
        function eventConsumed = handleSceneEvent(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_yes')...
                    && strcmp(e.action, 'ACTION'))
                obj.detailController.save(); 
                obj.detailController.close();
                obj.close(); 
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_no')...
                    && strcmp(e.action, 'ACTION'))
                obj.detailController.initScene(); 
                obj.detailController.close();
                obj.close();
                eventConsumed = 1; 
            end
        end 
    end
end
