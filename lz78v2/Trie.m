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

        function result = contains(obj, word)
            arguments
                obj Trie
                word
            end
            [~, last_index] = searchNode(obj, word);
            result = last_index == length(word);
        end

        function result = get(obj, word)
            arguments
                obj Trie
                word
            end
            [node, last_index] = searchNode(obj, word);
            if last_index == length(word)
                result = node;
            else
                result = [];
            end
        end

        function father_pos = add(obj, word, curr_pos)
            arguments
                obj Trie
                word
                curr_pos
            end
            
            [node, last_index] = searchNode(obj, word);
            if last_index == length(word)
                father_pos = node.father_pos;
                return;
            elseif last_index == length(word) - 1
                father_pos = insertNode(obj, node, word(end), curr_pos);
                return;
            else
                error('Prefisso fino all\''ultimo simbolo non trovato');
            end
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
                if isConfigured(node.children) && isKey(node.children, simb)
                    result = true;
                    position = obj.createPosition(node.children(simb));
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
                if (~isConfigured(node.children) || (isConfigured(node.children) && ~isKey(node.children, simb)))
                    father_pos = node.curr_pos;
                    node.children(simb) = Trie.createNode(simb, father_pos, curr_pos);
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
        function [father_pos, curr_pos] = insertNode(obj, node, simb, curr_pos)
            arguments
                obj Trie
                node TrieNode
                simb
                curr_pos
            end
            father_pos = node.curr_pos;
            node.children(simb) = Trie.createNode(simb, father_pos, curr_pos);
        end

        function [node, last_index] = searchNode(obj, word)
            arguments
                obj Trie
                word
            end
            node = obj.root;

            last_index = 0;
            for i=1:length(word)
                if isConfigured(node.children) && isKey(node.children, word(i))
                    node = node.children(word(i));
                    last_index = i;
                else
                    break;
                end
            end
        end

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

