function [result, rand_vector] = generatorePMFv2(pmf, simb, n)
%GENERATOREPMFV2 Genera n elementi a partire dalla sorgente
%   Data la pmf della sorgente, i suoi simboli, genera n elementi casuali.
    arguments
        pmf (:,1)
        simb
        n {mustBePositive}
    end

    if not(size(pmf) == size(simb))
        error('pmf and simb mismatch');
    end

    % Sorting della pmf e simboli in ordine decrescente di probabilità
    [pmf, order] = sort(pmf, 'descend');
    simb = simb(order, :);
    n_simb = numel(simb(:,end));

    % Generazione di valori da una v.a. uniforme
    rand_vector = rand(n, 1);
    % Generazione del vettore riga con gli intervalli (attraverso somma
    % cumulativa dei valori della pmf) e replicazione di questo n volte
    intervals = repmat(cumsum(pmf)', n, 1);
    % Replicazione del vettore colonna dei valori random n_simb volte (in
    % colonne)
    rand_matrix = repmat(rand_vector, 1, n_simb);
    % Generazione di una matrice n x n_simb logica secondo la condizione di
    % confronto
    result_simb_matrix = rand_matrix <= intervals;
    
    for i = 1:n
        % Recupero dell'indice del primo elemento non nullo nella matrice
        % logica in riga i. Questo corrisponde all'indice del simbolo
        % associato all'elemento casuale in posizione i
        idx = find(result_simb_matrix(i,:), 1);
        % Assegnazione del simbolo nel vettore colonna in posizione i
        result(i,:) = simb(idx,:);
    end
end

function mustBeValidPMF(value)
%MUSTBEVALIDPMF Verifica se la somma degli elementi è pari a 1
    if sum(value) ~= 1
        eidType = 'mustBeValidPMF:notValidPMF';
        msgType = 'Sum of elements in pmf must be equals to 1';
        throwAsCaller(MException(eidType,msgType));
    end
end

