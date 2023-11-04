function r = getHuffmanEncodedString(input, dict)
%GETHUFFMANENCODEDSTRING Restituisce il vettore codificato con Huffman a
%partire dal vettore input e dal dizionario simboli-parole codice
    arguments
        input
        dict dictionary
    end
    r = cell(size(input(:,1)));
    for i = 1:length(input(:,1))
        r(i) = dict({input(i,:)});
    end
end