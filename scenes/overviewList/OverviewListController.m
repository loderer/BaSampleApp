classdef OverviewListController < JFXSceneController
    %OverviewListController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model; 
        
        % ui elements
        list; 
    end
    
    methods
        function obj = OverviewListController(pathToFxml, model) 
            obj = obj@JFXSceneController(pathToFxml);
            obj.model = model; 
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.list = obj.getUiElement('list');
            
            % fill list
            obj.pushBackTask(obj.list, 'setCellFactory', jfx_4_matlab.cell_value_factory.JsonListCellValueFactory('surname'));
            data = javafx.collections.FXCollections.observableArrayList();
            for n = 1:size(obj.model.person)
                data.add(java.lang.String(mls.internal.toJSON(obj.model.person.get(n))));
            end
            obj.pushBackTask(obj.list, 'setItems', data);
            
            obj.applyTasks();
        end
        
        function eventConsumed = handleSceneEvent(obj, e) 
            eventConsumed = 0; 
            if(strcmp(e.fxId, 'btn_newEntry')...
                    && strcmp(e.action, 'ACTION'))
                obj.btnNewEntryPressed();
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_editEntry')... 
                        && strcmp(e.action, 'ACTION'))
                obj.btn_editEntryPressed();
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_save')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_savePressed();
                eventConsumed = 1;
            elseif(strcmp(e.fxId, 'btn_switchToTable')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_switchToTablePressed(); 
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_switchToPlot')...
                && strcmp(e.action, 'ACTION'))
                obj.btn_switchToPlotPressed();
                eventConsumed = 1;
            end
        end
        
        function btnNewEntryPressed(obj)
            detailStageController = JFXStageController(obj.getJfxApplicationAdapter(), 'Detail');
            detailSceneController = DetailController(strcat(Config.rootPath, '\scenes\detail\detail.fxml'), obj.model, obj);
            detailStageController.showScene(detailSceneController);
        end
        
        function btn_editEntryPressed(obj)
            selectionModel = obj.applyTask(obj.list, 'getSelectionModel'); 
            selectedItem = selectionModel.getSelectedItem();
            if(~isempty(selectedItem))
                person = mls.internal.fromJSON(selectedItem); 
            
                detailStageController = JFXStageController(obj.getJfxApplicationAdapter(), 'Detail');
                detailSceneController = DetailController(strcat(Config.rootPath, '\scenes\detail\detail.fxml'), obj.model, obj, person);
                detailStageController.showScene(detailSceneController);
            else
                disp('Select item!!!');
            end
        end
        
        function btn_savePressed(obj) 
            obj.model.writeJson();
        end
        
        function btn_switchToTablePressed(obj)
            overviewController = OverviewController(strcat(Config.rootPath, '\scenes\overview\overview.fxml'), obj.model);
            obj.getStageController().showScene(overviewController);
        end
        
        function btn_switchToPlotPressed(obj)
            plotController = PlotController(strcat(Config.rootPath, '\scenes\plot\plot.fxml'), obj.model);
            obj.getStageController().showScene(plotController);
        end
        
        function update(obj, oldItem, newItem) 
            data = obj.applyTask(obj.list, 'getItems');
            if(oldItem.id ~= -1) 
                obj.applyTask(data, 'remove', java.lang.String(savejson('', oldItem)));
            end
            obj.applyTask(data, 'add', java.lang.String(savejson('', newItem)));
        end
    end
end
