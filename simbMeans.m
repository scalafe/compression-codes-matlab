function [pmf, simb, means] = simbMeans(pmf, simb, n_sorg_est, exp_max_repl)
    arguments
        pmf (:,1)
        simb
        n_sorg_est {mustBeGreaterThanOrEqual(n_sorg_est, 1)}
        exp_max_repl {mustBeGreaterThanOrEqual(exp_max_repl, 1)}
    end

    % Creazione della sorgente estesa
    [pmf, simb] = sorgenteEstesa(pmf, simb, n_sorg_est);
    n_simb = numel(simb(:,end));
    
    % Creazione del vettore con il numero di elementi da generare per
    % esperimento
    exp_vector = round(logspace(1,exp_max_repl,exp_max_repl*10)');
    n_exp = numel(exp_vector);

    % Definizione di una matrice n_exp x n_simb per salvare le medie
    means = zeros(n_exp, n_simb);

    for i = 1:n_exp
        exp = exp_vector(i);
        %result = num2cell(generatorePMF(pmf, simb, exp), 2);

        % Generazione degli elementi e calcolo delle medie di comparsa dei
        % simboli nel vettore prima generato
        result = generatorePMFv2(pmf, simb, exp);
        for j = 1:n_simb
            means(i,j) = mean(arrayfun(@(rowidx) isequal(result(rowidx,:), simb(j,:)),1:size(result)));
        end
    end

    % Plot delle medie dei simboli per esperimento
    figure(1);
    semilogx(repmat(exp_vector, 1, n_simb), means, '-o', 'lineWidth', 1);
    grid on;
    legend(simb);
    ylabel('P(X = x)');
    xlabel('Lunghezza sequenza di simboli');
end
