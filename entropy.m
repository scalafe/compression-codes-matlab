function result = entropy(pmf)
    %ENTROPY Entropia della sorgente data la pmf
    result = -1 * sum(pmf.*log2(pmf));
end

