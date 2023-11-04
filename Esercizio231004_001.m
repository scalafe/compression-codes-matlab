clear all;
close all;

n_max = 10000;
n_vector = [1:100:n_max]';
mean1 = zeros(size(n_vector));
mean2 = zeros(size(n_vector));
mean3 = zeros(size(n_vector));
mean4 = zeros(size(n_vector));

pmf = [0.3;0.4;0.2;0.1];
simb = [1;2;3;4];

for i = 1:1:size(n_vector)
    [result, rand_vector] = generatorePMF(pmf, simb, n_vector(i));
    mean1(i) = mean(result == 1);
    mean2(i) = mean(result == 2);
    mean3(i) = mean(result == 3);
    mean4(i) = mean(result == 4);
end

plot(n_vector, mean1, n_vector, mean2,n_vector, mean3,n_vector, mean4)