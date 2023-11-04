classdef Heap < handle
    %HEAP Classe rappresentante un heap
    properties(Access = public)
        h = struct([]) %Array di supporto dell'heap
    end

    methods(Access = private)
        function r = parent(~, k)
            %PARENT Restituisce l'indice del genitore dell'elemento con
            %indice k nell'array h
            r = ceil((k-1)/2);
        end

        function r = left(~, k)
            %LEFT Restituisce l'indice del figlio sinistro dell'elemento
            %con indice k nell'array h
            r = 2*k;
        end

        function r = right(~, k)
            %RIGHT Restituisce l'indice del figlio destro dell'elemento
            %con indice k nell'array h
            r = 2*k+1;
        end

        function r = has_left(obj, k)
            %HAS_LEFT Verifica se esiste il figlio sinistro dell'elemento
            %con indice k nell'array h
            r = obj.left(k) <= length(obj.h);
        end

        function r = has_right(obj, k)
            %HAS_RIGHT Verifica se esiste il figlio destro dell'elemento
            %con indice k nell'array h
            r = obj.right(k) <= length(obj.h);
        end

        function swap(obj, k, l)
            %SWAP Effettua lo swap tra due elementi dato il loro indice
            %nell'array
            temp = obj.h(l);
            obj.h(l) = obj.h(k);
            obj.h(k) = temp;
        end

        function upheap(obj, k)
            %UPHEAP Effettua l'upheap dell'elemento con indice k
            parent = obj.parent(k);
            if (k > 1 && obj.h(k).key < obj.h(parent).key)
                obj.swap(k, parent)
                obj.upheap(parent)
            end
        end

        function downheap(obj, k)
            %DOWNHEAP Effettua il downheap dell'elemento con indice k
            if obj.has_left(k)
                left = obj.left(k);
                small_child = left;
                if obj.has_right(k)
                    right = obj.right(k);
                    if obj.h(right).key < obj.h(left).key
                        small_child = right;
                    end
                end
                if obj.h(small_child).key < obj.h(k).key
                    obj.swap(k, small_child);
                    obj.downheap(small_child);
                end
            end
        end

    end

    methods(Access = public)

        function r = is_empty(heap)
            %IS_EMPTY Verifica se l'heap è vuoto
            r = isempty(heap.h);
        end
        
        function add(obj, key, value)
            %ADD Aggiungi un elemento (priorità, valore) all'heap
            last_pos = length(obj.h) + 1;
            obj.h(last_pos).key = key;
            obj.h(last_pos).value = value;
            obj.upheap(last_pos);
        end

        function [key, value] = min(obj)
            %MIN Restituisce l'elemento con priorità più alta (chiave più
            %bassa)
            if obj.is_empty()
                error('Heap is empty');
            end
            item = obj.h(1);
            key = item.key;
            value = item.value;
        end

        function [key, value] = remove_min(obj)
            %REMOVE_MIN Effettua un pop dell'elemento con priorità più
            %alta (chiave più bassa)
            if obj.is_empty()
                error('Heap is empty');
            end
            item = obj.h(1);
            last_pos = length(obj.h);
            obj.swap(1, last_pos);
            obj.h(end) = [];
            obj.downheap(1);
            key = item.key;
            value = item.value;
        end

        function r = length(obj)
            %LENGTH Restituisce il numero di elementi nell'heap
            r = length(obj.h);
        end

    end
end