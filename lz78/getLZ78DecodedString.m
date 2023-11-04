function [result] = getLZ78DecodedString(input, encoded_simbols)
%GETLZ78DECODEDSTRING Summary of this function goes here
%   Detailed explanation goes here
    arguments
        input
        encoded_simbols
    end
    num_bits = @(num_elems) ceil(log2(num_elems));

    num_bits_simbols = num_bits(numel(encoded_simbols.keys));
    num_bits_indexes = numel(input(1,:)) - num_bits_simbols;

    decoded_simbols = dictionary(encoded_simbols.values, encoded_simbols.keys)

    result = cell(size(input,1),1);

    for ii=1:length(result)
        encoded_index = num2str(input(ii, 1:num_bits_indexes));
        encoded_index = encoded_index(~isspace(encoded_index));
        encoded_simbol = input(ii, num_bits_indexes+1:end);
        simbol = decoded_simbols({encoded_simbol});

        index = bin2dec(encoded_index);
        if index == 0
            result(ii) = simbol;
        else
            result(ii) = {[cell2mat(result(index));cell2mat(simbol)]};
        end
    end

    result = cell2mat(result);
end

