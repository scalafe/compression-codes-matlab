function result = getAvgCodeWordLength(pmf, simb, dict)
    arguments
        pmf (:,1)
        simb
        dict dictionary
    end

    result = 0;
    for i = 1:length(simb(:,end))
        result = result + pmf(i) * numel(cell2mat(dict({simb(i,:)})));
    end
end