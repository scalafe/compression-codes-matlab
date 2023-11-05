function [result] = getLZ78DecodedString(input, encoded_simbols)
%GETLZ78DECODEDSTRING Decodifa una stringa codificata con LZ78
%   Decodifica una stringa codificata con l'algoritmo LZ78.
%   -   input è la stringa codificata
%   -   encoded_simbols è il dizionario che associa ogni simbolo con la
%   propria codifica
    arguments
        input
        encoded_simbols
    end
    % Definizione funzione per il calcolo del numero di bit necessari per
    % codificare num_elems elementi
    num_bits = @(num_elems) ceil(log2(num_elems));

    % Calcolo del numero di bit necessari per codificare i simboli e gli
    % indici
    num_bits_simbols = num_bits(numel(encoded_simbols.keys));
    num_bits_indexes = numel(input(1,:)) - num_bits_simbols;

    % Creazione del dizionario che associa ogni codifica al suo simbolo
    % orginale, a partire da encoded_simbols
    decoded_simbols = dictionary(encoded_simbols.values, encoded_simbols.keys);

    % Inizializzazione dell'array di celle per conservare i risultati
    result = cell(size(input,1),1);

    % Decodifica della stringa input
    for ii=1:length(result)
        % Recupero tupla (father_pos, simb)
        encoded_index = num2str(input(ii, 1:num_bits_indexes));
        encoded_index = encoded_index(~isspace(encoded_index));
        encoded_simbol = input(ii, num_bits_indexes+1:end);
        simbol = decoded_simbols({encoded_simbol});

        % Recupero della frase associata alla tupla
        index = bin2dec(encoded_index);
        if index == 0
            result(ii) = simbol;
        else
            result(ii) = {[cell2mat(result(index));cell2mat(simbol)]};
        end
    end
   
    % Conversione dell'array di celle in una matrice
    result = cell2mat(result);
end

