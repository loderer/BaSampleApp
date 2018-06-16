classdef ModelMock < handle
    %MODELMOCK Summary of this class goes here
    %   Detailed explanation goes here
    properties
        addedPeople; 
    end
    
    methods
        function obj = ModelMock()
            obj.addedPeople = List(); 
        end
        
        function addPerson(obj, person) 
            obj.addedPeople.add(person);
         end
    end
    
end

