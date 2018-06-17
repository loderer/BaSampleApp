classdef Model < handle
    %MODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        id; 
        person;
    end
    
    methods
        function obj = Model()
            obj.id = 0; 
            obj.person = List();  
            obj.readJson();
        end
        
        function addPerson(obj, person) 
            person.setId(obj.id);
            obj.person.add(person);
            obj.id = obj.id + 1;
        end
        
        function updatePerson(obj, person) 
            for i=1:obj.person.size()
                if(obj.person.get(i).id == person.id)
                    break;
                end
            end
            obj.person.set(i, person);
        end
        
        function writeJson(obj) 
            jsonStr = mls.internal.toJSON(obj);
            fid = fopen(strcat(Config.rootPath, '\persistentModel.json'), 'w');
            if fid == -1, error('Cannot create JSON file'); end
            fwrite(fid, jsonStr, 'char');
            fclose(fid);
        end
        
        function readJson(obj)
            if(exist(strcat(Config.rootPath, '\persistentModel.json'), 'file') == 2)
                jsonText = fileread('\persistentModel.json');
                persistentModel = mls.internal.fromJSON(jsonText);
                obj.id = persistentModel.id; 
                obj.person = List();
                obj.person.fill(persistentModel.person);
            end
        end
    end
    
end

