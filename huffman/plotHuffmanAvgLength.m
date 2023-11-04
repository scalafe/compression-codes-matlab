function plotHuffmanAvgLength(pmf, simb, n_seq_max, n_max)
    arguments
        pmf (:,1)
        simb (:,1)
        n_seq_max = 10^5
        n_max = 3
    end

    entr = entropy(pmf);

    n=2.^[0:n_max];
    avgLengths = zeros(1,n_max+1);
    avgComputedLengths = zeros(1,n_max+1);
    for i = 1:length(n)
        [pmf_ext, simb_ext] = sorgenteEstesa(pmf, simb, n(i));
        dict = createHuffmanDict(pmf_ext, simb_ext);

        if n_seq_max > 0
            n_seq = round(n_seq_max / n(i));
            input = generatorePMFv2(pmf_ext, simb_ext, n_seq);
            encoded = getHuffmanEncodedString(input, dict);
            numBits = sum(cellfun(@numel, encoded));
            avgComputedLengths(i) = numBits/n_seq/n(i);
        end

        avgLengths(i) = getAvgCodeWordLength(pmf_ext, simb_ext, dict)/n(i);
        
    end

    figure;
    hold on;
    plot([1 n(end)], [entr entr], 'b-');
    plot(n, avgLengths);
    if n_seq_max > 0
        plot(n, avgComputedLengths)
    end
    xlim([1 n(end)]);
    legendStrings = {'Entropia'; 'AvgLength teorica'};
    if n_seq_max > 0
        legendStrings(end+1) = cellstr(strcat('AvgLength con lun seq = ', num2str(n_seq_max)));
    end
    legend(legendStrings);
    xlabel('Estensione n-esima');
    ylabel('Lunghezza media per parola');
    hold off;
end