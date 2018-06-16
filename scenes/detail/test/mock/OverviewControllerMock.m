classdef OverviewControllerMock < handle; 
    %OVERVIEWCONTROLLERMOCK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        updates; 
    end
    
    methods
        function obj = OverviewControllerMock() 
            obj.updates = {}; 
        end
        
        function update(obj, oldItem, newItem)
            if(isempty(obj.updates))
                obj.updates{1, 1} = oldItem; 
                obj.updates{1, 2} = newItem; 
            else
                obj.updates{size(obj.updates, 1) + 1, 1} = oldItem; 
                obj.updates{size(obj.updates, 1) + 1, 2} = newItem; 
            end
        end
    end
    
end

