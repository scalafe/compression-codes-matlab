function [pmf_result, simb_result] = sorgenteEstesa(pmf_orig, simb_orig, n)
%SORGENTEESTESA Crea la sorgente estesa fino ad n data una sorgente
%singola.
    arguments
        pmf_orig
        simb_orig
        n {mustBePositive}
    end

    if (n == 1)
        pmf_result = pmf_orig;
        simb_result = simb_orig;
        return;
    end
    
    %Chiamata ricorsiva
    [pmf_partial, simb_partial] = sorgenteEstesa(pmf_orig, simb_orig, n-1);

    %Prodottto tra ogni elemento di pmf_orig con tutto il vettore pmf_partial 
    pmf_result = kron(pmf_orig, pmf_partial);

    % Concatenazione di repliche delle matrici dei simboli
    simb_result = [repelem(simb_orig, numel(simb_partial(:,end))) repmat(simb_partial, size(simb_orig))];
end