function dict = createHuffmanDict(pmf, simb)
%CREATEHUFFMANDICT  Restituisce il dizionario con le parole codice della
%sorgente, utilizzando l'algoritmo di Huffman
    tree = createHuffmanTree(pmf, simb);
    dict = updateHuffmanDict(tree, []);
    
%     word_lengths = zeros(1, length(simb));
%     keys = dict.keys;
%     for i = 1:length(simb)
%         idx = arrayfun(@(rowidx) isequal({simb(rowidx, :)}, keys(i)), 1:length(simb));
%         word_lengths(i) = pmf(idx)*length(dict(keys(i)));
%     end
%     l = sum(word_lengths);
end

function T = createHuffmanTree(pmf, simb)
%CREATEHUFFMANTREE Generazione dell'albero di Huffman
    heap = Heap;

    % Inserimento degli alberi con solo radice (simbolo) nella coda a
    % priorità con priorità pari alla probabilità
    for i = 1:length(pmf)
        node = struct('value', simb(i,:), 'left', [], 'right', []);
        heap.add(pmf(i), node);
    end

    % Ciclo per unire i simboli fino a quando non si ricava un singolo
    % simbolo
    while length(heap) > 1
        % Recupero dei due alberi (simboli congiunti) con probabilità più
        % bassa
        [f1, T1] = heap.remove_min;
        [f2, T2] = heap.remove_min;

        % Unione dei due alberi per costruire un singolo simbolo con
        % probabilità pari alla somma delle singole probabilità
        f = f1 + f2;
        node = struct('value', [], 'left', T1, 'right', T2);
        heap.add(f, node);
    end

    % Recupero dell'albero con il singolo simbolo con probabilità unitaria
    [~, T] = heap.remove_min();
end

function dict = updateHuffmanDict(node, word)
%UPDATEHUFFMANDICT Restituisce il dizionario con i simboli a partire dal
%nodo node e dalla parola codice word

    % Se il nodo corrisponde a un simbolo della sorgente originaria e non
    % ha quindi figli allora restituisci un dizionario che associa il
    % simbolo a word
    if ~isempty(node.value)
        dict =  dictionary({node.value}, {word});
        return;
    end

    left = node.left;
    right = node.right;

    % Recupero dei dizionari costruiti a partire dai sottoalberi
    left_dict = updateHuffmanDict(left, [word 1]);
    right_dict = updateHuffmanDict(right, [word 0]);

    % Unione dei dizionari in uno solo
    dict = dictionary([left_dict.keys;right_dict.keys], ...
        [left_dict.values;right_dict.values]);
end