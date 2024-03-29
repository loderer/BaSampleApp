classdef List < handle
    %SET Simple implementation of a set. 
    
    properties(Access = private)
        % The first item of the list.
        head; 
    end
    
    methods
        function obj = List() 
            obj.head = -1;
        end
        
        function fill(obj, rawList) 
            % Enables filling the list from a struct. 
            % params:
            % obj
            % rawList: Struct representing list. 
            obj.head = ListItem(-1);
            obj.head.fill(rawList.head); 
        end
        
        function exists = add(obj, value) 
            % Adds a value to the end of the list. 
            % params:
            % obj
            % value: The value to be added.
            exists = false;
            if(obj.head == -1)
                obj.head = ListItem(value); 
            else 
                actItem = ListItem(-1); 
                actItem.setNext(obj.head); 
                while(actItem.getNext() ~= -1)
                    actItem = actItem.getNext();
                    if(isequal(actItem.getValue(), value))
                        exists = true; 
                        break; 
                    end 
                end
                if(~exists) 
                    actItem.setNext(ListItem(value)); 
                end
            end
        end
        
        function exists = remove(obj, value) 
            % Removes a value from the list. 
            % params:
            % obj
            % value: The value to be removed.
           exists = false; 
           if(~obj.isEmpty())
               if(isequal(obj.head.getValue(), value))
                    obj.head = obj.head.getNext();
                    exists = true; 
               else
                   actItem = obj.head; 
                   while(actItem.getNext() ~= -1)
                       if(isequal(actItem.getNext().getValue(), value))
                           actItem.setNext(actItem.getNext().getNext());
                           exists = true; 
                           break; 
                       end
                       actItem = actItem.getNext(); 
                   end
               end
           end
        end
        
        function isEmpty = isEmpty(obj) 
            % Checks if the list is empty.
            if(obj.head == -1)
                isEmpty = true; 
            else
                isEmpty = false;
            end
        end
        
        function size = size(obj) 
            % Determines the number of contained items.
            if(isequal(obj.head, -1))
                size = 0; 
            else
                size = obj.head.childCount() + 1;
            end 
        end
        
        function value = get(obj, index) 
            % Fetches an item by its index.
            % Use the index one to get the first item!
            % params:
            % obj
            % index: The index of the item to be fetched. 
            if(index > 0) 
                tmpItem = ListItem(-1); 
                tmpItem.setNext(obj.head);
                value = tmpItem.get(index);
            else
                msgID = 'EXCEPTION:IndexOutOfBounds';
                msg = 'The first possible index in a list is one.';
                throw(MException(msgID,msg));
            end
        end
        
        function oldValue = set(obj, index, newValue) 
            % Replaces an item with another. The item to be replaced is
            % specified by its index.
            % Use the index one to replace the first item!
            % params:
            % obj
            % index: The index of the item to be replaced. 
            % newValue: The new item.
            if(index > 0) 
                tmpItem = ListItem(-1); 
                tmpItem.setNext(obj.head);
                oldValue = tmpItem.set(index, newValue);
            else
                msgID = 'EXCEPTION:IndexOutOfBounds';
                msg = 'The first possible index in a list is one.';
                throw(MException(msgID,msg));
            end
        end
        
        function value = toCell(obj) 
            % Creates an array-representation of this list.
            value=cell(obj.size(), 1);
            for i = 1 : obj.size()
                value{i, 1} = obj.get(i);
            end
        end
    end
end

