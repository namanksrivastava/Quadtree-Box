classdef subdivision < handle
    properties
        RootBox
        Register = {}
        LastIdx = 1
    end
    methods
        function obj = subdivision(x,y,w)
            obj.RootBox = box(x,y,w);
            display(obj.RootBox);
            obj.Register{obj.LastIdx} = obj.RootBox;
        end
        function split(obj,boxIndex)
            box = obj.Register{boxIndex};
            assert(isa(box,'box'),'Not box object', class(box));
            children = box.split();
            for i = 1:4
                regBox(obj,box,children(i),i);
            end
        end
        function regBox(obj,box,childBox,childIndex)
            obj.LastIdx = obj.LastIdx + 1;
            obj.Register{obj.LastIdx} = childBox;
            box.MyChild{childIndex} = obj.LastIdx; 
        end
        function boxIndex = findBox(obj,x,y)
            boxIndex = 1;
            box = obj.Register{1};
            assert(isa(box,'box'),'Not box object', class(box));
            while(box.IsLeaf == 0)
                %disp(['boxIsLeaf =', num2str(box.IsLeaf)]);
                boxIndex = cell2mat(findChild(obj,box,x,y));
                box = obj.Register{boxIndex};
            end
        end
        function boxIndex = findChild(~,box,x,y)
            assert(isa(box,'box'),'Not box object', class(box));
            if(x < box.x)
                if(y < box.y)
                     boxIndex = box.MyChild(3);
                else
                     boxIndex = box.MyChild(2);
                end
            else
                if(y < box.y)
                     boxIndex = box.MyChild(4);
                else
                     boxIndex = box.MyChild(1);
                end
            end
        end
        function showSubDiv(obj)
            display(obj.RootBox);
        end
        function showReg(obj)
            for box = 1:length(obj.Register)
                display(obj.Register{box});
            end
        end
    end
    methods (Static = true)
        function test()
            s = subdivision(0,0,1);
            %display(s.Register{1});
            %s.showSubDiv();
            %s.showReg();
            s.split(1);
            %display(s.Register{3});
            %s.showReg();
            boxIndex = s.findBox(0.5,0.5);
            %box = s.Register{boxIndex};
            s.split(boxIndex);
            newBoxIndex = s.findBox(0.25,0.75);
            box = s.Register{newBoxIndex};
            box.showBox();
            %box.showBox();
        end
    end
end