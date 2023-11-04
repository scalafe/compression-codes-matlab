function r = getHuffmanDecodedString(input, dict)
%GETHUFFMANDECODEDSTRING Restituisce il vettore decodificato con Huffman a
%partire dal vettore input codificaro e dal dizionario simboli-parole 
%codice
    inverted_dict = dictionary(dict.values, dict.keys);
    r = cell(size(input));

    for i = 1:length(input)
        r(i) = inverted_dict(input(i));
    end

    r = cell2mat(r);
end