function [pmf_result] = sorgenteEstesaNoSimb(pmf_orig, n)
%SORGENTEESTESA Crea la sorgente estesa fino ad n data una sorgente
%singola.
    arguments
        pmf_orig
        n {mustBePositive}
    end

    if (n == 1)
        pmf_result = pmf_orig;
        return;
    end
    
    %Chiamata ricorsiva
    [pmf_partial] = sorgenteEstesaNoSimb(pmf_orig, n-1);

    %Prodottto tra ogni elemento di pmf_orig con tutto il vettore pmf_partial 
    pmf_result = kron(pmf_orig, pmf_partial);
end
