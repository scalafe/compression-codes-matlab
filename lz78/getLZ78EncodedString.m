function [result, simbols, encoded_simbols, tuples] = getLZ78EncodedString(input)
%GETLZ78ENCODEDSTRING Codifca una stringa di simboli
%   Codifca una stringa di simboli utilizzando l'algoritmo LZ78
%   Parametri:
%   -   input è la stringa da codificare
%   Valori di ritorno:
%   -   result è la stringa codificata;
%   -   simbols è il vettore con tutti i simboli elementari trovati durante
%   l'esecuzione;
%   -   encoded_simbols è il dizionario che associa ogni simbolo con la
%   codifica assegnatagli;
%   -   tuples è l'array di celle che contiene le coppie (father_pos, simb)
%   che definiscono le frasi individuate durante il parsing
    arguments
        input
    end
    num_bits = @(num_elems) ceil(log2(num_elems));

    % Recupero delle tuple delle frasi dalla stringa
    [tuples, simbols, num_phrases] = getLZ78EncodedTuples(input);

    % Recupero della massimo valore di father_pos delle tuple
    max_tuple_index = max(cell2mat(tuples(:,1)));

    % Calcolo del numero di bit necessari per codificare gli indici e i
    % simboli in binario
    num_bits_indexes = num_bits(max_tuple_index + 1);
    num_bits_simbols = num_bits(numel(simbols(:,1)));

    % Inizializzazione dell'array finale e del dizionario delle codifiche
    % dei simboli
    result = zeros(num_phrases, num_bits_simbols + num_bits_indexes);
    encoded_simbols = dictionary();

    % Creazione delle codifiche dei simboli elementari
    for ii = 1:numel(simbols(:,1))
        simbol = simbols(ii,:);
        jj = ii - 1;
        encoded_simbols(simbol) = {double(dec2bin(jj, num_bits_simbols) == '1')};
    end

    % Codifca delle tuple in binario
    for ii = 1:num_phrases
        index = tuples(ii,1);
        simbol = tuples(ii,2);
        result(ii,1:num_bits_indexes) = double(dec2bin(cell2mat(index), num_bits_indexes) == '1');
        result(ii,num_bits_indexes+1:end) = cell2mat(encoded_simbols(simbol));
    end
end

