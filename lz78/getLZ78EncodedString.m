function [result, simbols, encoded_simbols, tuples] = getLZ78EncodedString(input)
%GETLZ78ENCODEDSTRING Summary of this function goes here
%   Detailed explanation goes here
    arguments
        input
    end
    num_bits = @(num_elems) ceil(log2(num_elems));

    [tuples, simbols, num_phrases] = getLZ78EncodedTuples(input);

    max_tuple_index = max(cell2mat(tuples(:,1)));

    num_bits_indexes = num_bits(max_tuple_index + 1);
    num_bits_simbols = num_bits(numel(simbols(:,1)));

    result = zeros(num_phrases, num_bits_simbols + num_bits_indexes);

    encoded_simbols = dictionary();

    for ii = 1:numel(simbols(:,1))
        simbol = simbols(ii,:);
        jj = ii - 1;
        encoded_simbols(simbol) = {double(dec2bin(jj, num_bits_simbols) == '1')};
    end

    for ii = 1:num_phrases
        index = tuples(ii,1);
        simbol = tuples(ii,2);
        result(ii,1:num_bits_indexes) = double(dec2bin(cell2mat(index), num_bits_indexes) == '1');
        result(ii,num_bits_indexes+1:end) = cell2mat(encoded_simbols(simbol));
    end
end

