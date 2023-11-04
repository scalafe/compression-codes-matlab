classdef TrieNode < handle
    %TRIENODE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess = public, SetAccess = public)
        simb
        father_pos
        curr_pos
        children
    end
    
    methods
        function obj = TrieNode(simb, father_pos, curr_pos)
            %TRIENODE Construct an instance of this class
            %   Detailed explanation goes here
            obj.simb = simb;
            obj.father_pos = father_pos;
            obj.curr_pos = curr_pos;
            obj.children = dictionary();
        end

        function tuple = getTuple(obj)
            tuple = {obj.father_pos, obj.simb};
        end

    end
end

