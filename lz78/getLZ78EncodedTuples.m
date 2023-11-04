function [result, simbols, num_phrases] = getLZ78EncodedTuples(input)
%GETLZ78ENCODEDTUPLES Summary of this function goes here
%   Detailed explanation goes here
    arguments
        input
    end

    trie = Trie();
    result = cell(0,2);
    simbols_dict = dictionary();
    num_phrases = 0;

    jj = 1;
    current_position = trie.getRootPosition();
    inserted = false;
    for ii = 1:length(input(:,end))
        if jj == ii
            current_position = trie.getRootPosition();
            inserted = false;
        end

        current_simbol = input(ii,:);
        [found, next_position] = trie.traversePosition(current_position, current_simbol);
        if found
            current_position = next_position;
        else
            num_phrases = num_phrases + 1;
            father_pos = trie.addInPosition(current_position, current_simbol, num_phrases);
            jj = ii + 1;
            result(end+1,:) = {father_pos, current_simbol};

            if isConfigured(simbols_dict) && isKey(simbols_dict, {current_simbol})
                simbols_dict({current_simbol}) = simbols_dict({current_simbol}) + 1;
            else
                simbols_dict({current_simbol}) = 1;
            end
            inserted = true;
        end
    end
    simbols = simbols_dict.keys;

    if inserted == false && found == true
        result(end+1,:) = current_position.getNodeTuple();
        num_phrases = num_phrases + 1;
    end
end

