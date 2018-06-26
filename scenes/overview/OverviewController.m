classdef OverviewController < JFXSceneController
    %OverviewController An instance of this class observes the gui.
    %   This class maps every event to an appropriate callback.
    
    properties
        model; 
        
        % ui elements
        tc_name;
        tc_surname; 
        tc_gender; 
        tc_age;
        table;
    end
    
    methods
        function obj = OverviewController(pathToFxml, model) 
            obj = obj@JFXSceneController(pathToFxml);
            obj.model = model; 
        end
        
        function initScene(obj)
            % fetch ui elements
            obj.tc_name = obj.getUiElement('tc_name');
            obj.tc_surname = obj.getUiElement('tc_surname');
            obj.tc_gender = obj.getUiElement('tc_gender');
            obj.tc_age = obj.getUiElement('tc_age');
            obj.table = obj.getUiElement('table');
            
            % Fill table.
            obj.pushBackTask(obj.tc_name, 'setCellValueFactory', jfx_4_matlab.cell_value_factory.JsonTableCellValueFactory('name')); 
            obj.pushBackTask(obj.tc_surname, 'setCellValueFactory', jfx_4_matlab.cell_value_factory.JsonTableCellValueFactory('surname')); 
            obj.pushBackTask(obj.tc_gender, 'setCellValueFactory', jfx_4_matlab.cell_value_factory.JsonTableCellValueFactory('gender'));
            obj.pushBackTask(obj.tc_age, 'setCellValueFactory', jfx_4_matlab.cell_value_factory.JsonTableCellValueFactory('age'));
            data = javafx.collections.FXCollections.observableArrayList();
            for n = 1:obj.model.person.size()
                data.add(java.lang.String(mls.internal.toJSON(obj.model.person.get(n))));
            end
            obj.pushBackTask(obj.table, 'setItems', data);
            
            obj.applyTasks();
        end
        
        function eventConsumed = onSceneAction(obj, e) 
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
            elseif(strcmp(e.fxId, 'btn_switchToList')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_switchToListPressed(); 
                eventConsumed = 1; 
            elseif(strcmp(e.fxId, 'btn_switchToPlot')...
                    && strcmp(e.action, 'ACTION'))
                obj.btn_switchToPlotPressed(); 
                eventConsumed = 1; 
            end
        end
        
        function btnNewEntryPressed(obj)
            detailStageController = JFXStageController(obj.getJfxApp(), 'Detail');
            detailSceneController = DetailController(strcat(Config.rootPath, '\scenes\detail\detail.fxml'), obj.model, obj);
            detailStageController.showScene(detailSceneController);
        end
        
        function btn_editEntryPressed(obj)
            selectionModel = obj.applyTask(obj.table, 'getSelectionModel'); 
            selectedItem = selectionModel.getSelectedItem();
            if(~isempty(selectedItem))
                person = mls.internal.fromJSON(selectedItem); 
            
                detailStageController = JFXStageController(obj.getJfxApp(), 'Detail');
                detailSceneController = DetailController(strcat(Config.rootPath, '\scenes\detail\detail.fxml'), obj.model, obj, person);
                detailStageController.showScene(detailSceneController);
            else
                disp('Select item!!!');
            end
        end
        
        function btn_savePressed(obj) 
            obj.model.writeJson();
        end
        
        function btn_switchToListPressed(obj)
            overviewListController = OverviewListController(strcat(Config.rootPath, '\scenes\overviewList\overviewList.fxml'), obj.model);
            obj.stageController.showScene(overviewListController);
        end
        
        function btn_switchToPlotPressed(obj)
            plotController = PlotController(strcat(Config.rootPath, '\scenes\plot\plot.fxml'), obj.model);
            obj.stageController.showScene(plotController);
        end
        
        function update(obj, oldItem, newItem) 
            data = obj.applyTask(obj.table, 'getItems');
            if(oldItem.id ~= -1) 
                data.remove(java.lang.String(mls.internal.toJSON(oldItem)));
            end
            data.add(java.lang.String(mls.internal.toJSON(newItem)));
        end
    end
end
