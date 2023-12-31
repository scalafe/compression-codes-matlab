function [result, simbols, num_phrases] = getLZ78EncodedTuples(input)
%GETLZ78ENCODEDTUPLES Restituisce le tuple ottenute con il parsing di LZ78.
%   Data una sequenza di simboli in input, restituisce le tuple
%   (father_pos, simb) che individuano le frasi trovate durante il parsing
%   dell'algoritmo LZ78.
%   Parametri:
%   -   input: stringa da analizzare
%   Valori restituiti:
%   -   result: tuple trovate;
%   -   simbols: vettore dei simboli elementari trovati durante il parsing;
%   -   num_phrases: numero di frasi trovate durante il parsing.
    arguments
        input
    end

    % Inizializzazione delle strutture di supporto
    trie = Trie();
    result = cell(length(input(:,end)),2);
    simbols_dict = dictionary();
    num_phrases = 0;

    % Esecuzione dell'algoritmo LZ78
    jj = 1;
    current_position = trie.getRootPosition();
    inserted = false;
    for ii = 1:length(input(:,end))
        % Se gli indici corrispondono parti dall'alto dell'albero dei
        % prefissi
        if jj == ii
            current_position = trie.getRootPosition();
            inserted = false;
        end

        % Recupero del simbolo dalla stringa e verifica
        % dell'attraversamento dell'albero
        current_simbol = input(ii,:);
        [found, next_position] = trie.traversePosition(current_position, current_simbol);

        % Se esiste il nodo che rappresenta il simbolo corrente nella frase
        % attualmente analizzata allora aggiorna la posizione nell'albero
        % corrente
        if found
            current_position = next_position;

        % Se il nodo non esiste allora crealo e salva la frase trovata
        else
            num_phrases = num_phrases + 1;
            
            % Aggiunta del nodo nell'albero nella posizione che corrisponde
            % alla fine del prefisso della frase analizzata
            father_pos = trie.addInPosition(current_position, current_simbol, num_phrases);
            jj = ii + 1;

            % Salvataggio della tupla (father_pos, current_simb)
            result(num_phrases,:) = {father_pos, current_simbol};

            % Aggiornamento del numero di occorrenze del simbolo elementare
            % nella stringa
            if isConfigured(simbols_dict) && isKey(simbols_dict, {current_simbol})
                simbols_dict({current_simbol}) = simbols_dict({current_simbol}) + 1;
            else
                simbols_dict({current_simbol}) = 1;
            end
            inserted = true;
        end
    end
    simbols = simbols_dict.keys;

    % Salvataggio dell'ultima frase trovata ancora non inserita nei
    % risultati
    if inserted == false && found == true
        result(num_phrases+1,:) = current_position.getNodeTuple();
        num_phrases = num_phrases + 1;
    end

    result = result(1:num_phrases,:);
end

