function [result, rand_vector] = generatorePMF(pmf, simb, n)
%     if sum(pmf) ~= 1.0
%         error('Not valid pmf');
%     end
    if not(size(pmf) == size(simb))
        error('pmf and simb mismatch');
    end
    if n < 1
        error('n is not stricly positive');
    end

    [pmf, order] = sort(pmf, 'descend');
    simb = simb(order, :);
    
    pmf_sum = pmf;
    for i = [2:size(pmf)]
        pmf_sum(i) = pmf_sum(i) + pmf_sum(i-1);
    end
    intervals = [0 pmf_sum(1); pmf_sum(1:end-1) pmf_sum(2:end)];

    %result = zeros(n, 1);
    rand_vector = rand(n,1);
    for i = [1:n]
        idx = find(rand_vector(i) >= intervals(:, 1) & rand_vector(i) < intervals(:, 2));
        result(i, :) = simb(idx, :);
    end
end