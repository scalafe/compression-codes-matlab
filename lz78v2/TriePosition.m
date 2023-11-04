classdef TriePosition < handle
    %TRIEPOSITION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(GetAccess = {?Trie, ?TrieNode})
        trie Trie
        node TrieNode
    end
    
    methods
        function obj = TriePosition(trie, node)
            %TRIEPOSITION Construct an instance of this class
            %   Detailed explanation goes here
            obj.trie = trie;
            obj.node = node;
        end
        
        function result = isFromTrie(obj, trie)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            result = trie == obj.trie;
        end

        function tuple = getNodeTuple(obj)
            tuple = obj.node.getTuple();
        end
    end
end

