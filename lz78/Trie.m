classdef Trie < handle
    %TRIE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Access = private)
        root TrieNode
    end
    
    methods
        function obj = Trie(obj)
            obj.root = Trie.createNode([], -1, 0);
        end

        function position = getRootPosition(obj)
            position = createPosition(obj, obj.root);
        end

        function [result, position] = traversePosition(obj, position, simb)
            arguments
                obj Trie
                position TriePosition
                simb
            end
            if checkPosition(obj, position)
                node = position.node;
                if isConfigured(node.children) && isKey(node.children, {simb})
                    result = true;
                    position = obj.createPosition(node.children({simb}));
                else
                    result = false;
                    position = [];
                end
            else
                error('La position fa riferimento ad un altro albero');
            end
        end

        function father_pos = addInPosition(obj, position, simb, curr_pos)
            arguments
                obj Trie
                position TriePosition
                simb
                curr_pos
            end
            if checkPosition(obj, position)
                node = position.node;
                if (~isConfigured(node.children) || (isConfigured(node.children) && ~isKey(node.children, {simb})))
                    father_pos = node.curr_pos;
                    node.children({simb}) = Trie.createNode(simb, father_pos, curr_pos);
                else
                    error('Simbolo già presente nella Position');
                end
            else
                error('Position non fa riferimento al trie');
            end

        end
    end

    methods(Static, Access = private)
        function node = createNode(simb, father_pos, curr_pos)
            arguments
                simb
                father_pos
                curr_pos
            end
            node = TrieNode(simb, father_pos, curr_pos);
        end
    end

    methods(Access = private)
        function [position] = createPosition(obj, node)
            arguments
                obj Trie
                node TrieNode
            end
            position = TriePosition(obj, node);
        end

        function result = checkPosition(obj, position)
            arguments
                obj Trie
                position TriePosition
            end
            result = position.isFromTrie(obj);
        end
    end
end

