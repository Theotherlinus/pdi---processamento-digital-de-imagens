%livia_maia_claudio 222050030%
clc;
clear all;
close all;
pkg load image;

function compressed = rle_binary(imagem)
    % Converte a imagem para vetor linha
    vetor = imagem';    % transpõe
    vetor = vetor(:);   % agora lineariza em ordem por linhas

    compressed = [];
    count = 1;

    for i = 2:length(vetor)
        if vetor(i) == vetor(i-1)
            count = count + 1;
        else
            compressed = [compressed, vetor(i-1), count];

            count = 1;
        end
    end

    % Adiciona o último run
    compressed = [compressed, vetor(end), count];
end

function imagem = decode_rle_binary(compressed, linhas, colunas)
    imagem = [];

    for i = 1:2:length(compressed)
        valor = compressed(i);
        contador = compressed(i+1);
        imagem = [imagem, valor * ones(1, contador)];
    end

    imagem = reshape(imagem, linhas, colunas);
end

function compressed = rle_gray(imagem)
    % Converte para vetor considerando varredura por linha
    vetor = imagem';
    vetor = vetor(:)';

    compressed = [];

    if isempty(vetor)
        return;
    end

    valor_atual = vetor(1);
    count = 1;

    for i = 2:length(vetor)
        if vetor(i) == valor_atual && count < 255
            count = count + 1;
        else
            compressed = [compressed, valor_atual, count];
            valor_atual = vetor(i);
            count = 1;
        end
    end

    compressed = [compressed, valor_atual, count];
end

function imagem = decode_rle_gray(compressed, linhas, colunas)
    if isempty(compressed)
        imagem = [];
        return;
    end

    imagem = [];

    for i = 1:2:length(compressed)
        valor = compressed(i);
        contador = compressed(i+1);
        imagem = [imagem, valor * ones(1, contador)];
    end

    % Remodela para dimensões originais
    imagem = reshape(imagem, colunas, linhas)';
end

function taxa = calcular_taxa_compressao(original, comprimido)
    bits_original = numel(original) * 8; % Assumindo 8 bits por pixel
    bits_comprimido = numel(comprimido) * 8; % Cada elemento também com 8 bits
    taxa = bits_original / bits_comprimido;
end

function relatorio_desempenho(imagem, compressed, nome)
    fprintf('\n=== %s ===\n', nome);
    fprintf('Dimensões: %dx%d\n', size(imagem,1), size(imagem,2));
    fprintf('Tamanho original: %d pixels\n', numel(imagem));
    fprintf('Tamanho comprimido: %d elementos\n', numel(compressed));
    fprintf('Taxa de compressão: %.2f:1\n', calcular_taxa_compressao(imagem, compressed));
    fprintf('Redução: %.1f%%\n', (1 - numel(compressed)/numel(imagem)) * 100);
end
