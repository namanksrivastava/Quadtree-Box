% We need boxes as objects
%	in quadtrees, so that we have "pointers" to them.
% One way is to use handles to boxes.
%	But in this class, we will simulate our own pointers.
%	This means that every created box is put into a
%	Box Register, namely an array.
%	The index into this Box Register is the pointer to the box!
%{
	
%}


classdef box < handle
    properties
        x
        y
        w
        MyChild = {}
        IsLeaf = true
    end

    methods
        function obj = box(a,b,c)
            obj.x = a;
            obj.y = b;
            obj.w = c;
        end
        function children = split(obj)
            children = [box(obj.x+obj.w/2,obj.y+obj.w/2,obj.w/2),
                box(obj.x-obj.w/2,obj.y+obj.w/2,obj.w/2),
                box(obj.x-obj.w/2,obj.y-obj.w/2,obj.w/2),
                box(obj.x+obj.w/2,obj.y-obj.w/2,obj.w/2)];
            obj.IsLeaf = false;
        end
        function showBox(obj)
            disp([ num2str(obj.x),', ' , num2str(obj.y),', ', num2str(obj.w)]);
        end
    end
    methods (Static = true)
        function test()
            b = box(0,0,1)
            b.showBox();
            disp(['root is leaf? ',num2str(b.IsLeaf)]);
            children = b.split();
            children(1).showBox();
            disp(['root is leaf? ',num2str(b.IsLeaf)]);
            disp(['child is leaf? ',num2str(children(1).IsLeaf)]);
        end
    end
end