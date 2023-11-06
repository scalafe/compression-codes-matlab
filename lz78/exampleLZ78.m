% Definizione PMF e simboli
n_simb = 6;
rand_values = rand(n_simb,1);
pmf = rand_values/sum(rand_values);
simb = ['A':char('A'+n_simb)]';

% Generazione della stringa casuale
input = generatorePMFv2(pmf, simb, 10^6);

% Codifica
[encoded, ~, encoded_simbols] = getLZ78EncodedString(input);

% Decodifica
decoded = getLZ78DecodedString(encoded, encoded_simbols);

% Verifica uguaglianza input e dencoded
isequal(input, decoded)

