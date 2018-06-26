classdef DetailTest < matlab.unittest.TestCase
 
    properties
        person; 
        model;
        overviewSceneController; 
        jfxApplicationAdapter;
        detailStageController;
        detailSceneController;
    end
     
    methods(TestMethodSetup)
        function setupApplication(testCase)
            testCase.person = Person(-1, 'Rudi', 'Loderer', Gender.male, 22); 
            testCase.model = ModelMock();
            testCase.overviewSceneController = OverviewControllerMock(); 
            testCase.jfxApplicationAdapter = JFXApplicationAdapter();
            testCase.detailStageController = JFXStageController('Detail', testCase.jfxApplicationAdapter);
            testCase.detailSceneController = DetailController(...
                fullfile(Config.rootPath, 'scenes', 'detail', 'detail.fxml'),...
                testCase.model, testCase.overviewSceneController, testCase.person);
            testCase.detailStageController.showScene(testCase.detailSceneController);
        end
    end
 
    methods(TestMethodTeardown)
        function closeFigure(testCase)
            allStageControllers = testCase.jfxApplicationAdapter.getAllStageControllers();
            for i = 1 : size(allStageControllers)
                allStageControllers.get(i).sceneController.forceClose(); 
            end
        end
    end
 
    methods(Test)
 
        function initNameTest(testCase)
            tf_name_value = char(testCase.detailSceneController.tf_name.getText()); 
            testCase.verifyEqual(tf_name_value, testCase.person.name, ...
                'Field name incorrect initialized.')
        end
        
        function initSurnameTest(testCase)
            tf_surname_value = char(testCase.detailSceneController.tf_surname.getText()); 
            testCase.verifyEqual(tf_surname_value, testCase.person.surname, ...
                'Field surname incorrect initialized.')
        end
        
        function initRBFemaleTest(testCase)
            rb_female_selected = testCase.detailSceneController.rb_female.isSelected();
            testCase.verifyEqual(rb_female_selected, false, ...
                'Radio button female incorrect initialized.') 
        end
        
        function initRBMaleTest(testCase)
            rb_male_selected = testCase.detailSceneController.rb_male.isSelected();
            testCase.verifyEqual(rb_male_selected, true, ...
                'Radio button male incorrect initialized.')
        end
        
        function initSliderAgeTest(testCase)
            slider_age_value = testCase.detailSceneController.slider_age.getValue();
            testCase.verifyEqual(slider_age_value, testCase.person.age, ...
                'Slider age incorrect initialized.')
        end
        
        function isCloseableTest(testCase)
            isCloseable = testCase.detailSceneController.isCloseable();
            testCase.verifyEqual(isCloseable, true, ...
                'Scene is unexpectedly not closeable.');  
        end
        
        function doNotOpenDialogTest(testCase) 
            testCase.detailSceneController.isCloseable();
            dialogStageControllers = testCase.jfxApplicationAdapter.getStageControllerByTitle('Unsaved changes!');
            testCase.verifyEqual(dialogStageControllers.isEmpty(), true, ...
                'Unsaved changes dialog should not be visible!');
        end
        
        function isNotCloseableTest(testCase)
            testCase.detailSceneController.tf_name.setText('anotherName')
            isCloseable = testCase.detailSceneController.isCloseable();
            testCase.verifyEqual(isCloseable, false, ...
                'Scene is unexpectedly closeable.'); 
        end
        
        function openDialogTest(testCase)
            testCase.detailSceneController.tf_name.setText('anotherName')
            testCase.detailSceneController.isCloseable();  
            dialogStageControllers = ...
                testCase.jfxApplicationAdapter.getStageControllerByTitle('Unsaved changes!');
            testCase.verifyEqual(dialogStageControllers.isEmpty(), false, ...
                'Unsaved changes dialog should be visible!'); 
        end
 
        function addPersonTest(testCase)
            testCase.detailSceneController.applyTask(...
                testCase.detailSceneController.slider_age, 'setValue', 42);
            testCase.detailSceneController.save(); 
            addedPeople = testCase.model.addedPeople; 
            testCase.verifyEqual(addedPeople.isEmpty(), false, ...
                'No person has been added.');
        end
        
        function updateOverviewTest(testCase)
            testCase.detailSceneController.applyTask(...
                testCase.detailSceneController.slider_age, 'setValue', 42);
            testCase.detailSceneController.save(); 
            updates = testCase.overviewSceneController.updates; 
            testCase.verifyEqual(isempty(updates), false, ...
                'No update on overview.');
        end
    end
 
end