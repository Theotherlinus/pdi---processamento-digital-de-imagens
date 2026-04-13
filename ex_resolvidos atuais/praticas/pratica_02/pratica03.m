% livia_maia_claudio 222050030
% Prática 03 - Filtros Espaciais em Imagens Médicas: Suavização e Realce

pkg load image;
close all;
clc;

base_dir = 'medicas';

arquivos = {
    'mamografia6.png', ...
    'ct1012.png', ...
    'mricerebro1.jpg', ...
    'distal_fracture1.jpg', ...
    '10 no.jpg' ...
};

rotulos = {
    'Mamografia', ...
    'Tomografia', ...
    'Ressonância (Cérebro)', ...
    'Raio-X (Fratura)', ...
    'Imagem com Ruído' ...
};

kernel_media = 3;
kernel_mediana = 3;

filtro_media = fspecial('average', [kernel_media kernel_media]);
filtro_laplaciano = fspecial('laplacian', 0.2);
indice_imagem_ruidosa = 5;

for i = 1:length(arquivos)
    caminho = fullfile(base_dir, arquivos{i});

    if exist(caminho, 'file') ~= 2
        fprintf('Arquivo não encontrado: %s\n', caminho);
        continue;
    end

    img = imread(caminho);

    if ndims(img) == 3
        img_cinza = rgb2gray(img);
    else
        img_cinza = img;
    end

    img_cinza = im2double(img_cinza);

    img_media = imfilter(img_cinza, filtro_media, 'replicate');
    img_mediana = medfilt2(img_cinza, [kernel_mediana kernel_mediana]);

    if i == indice_imagem_ruidosa
        lap = imfilter(img_cinza, filtro_laplaciano, 'replicate');
        img_laplaciano = mat2gray(abs(lap));
        img_agucada = img_cinza - lap;
        img_agucada = mat2gray(img_agucada);
        titulo_lap = 'Laplaciano (resposta)';
        titulo_aguc = 'Aguçamento (Original - Laplaciano)';
    else
        img_laplaciano = img_cinza;
        img_agucada = img_cinza;
        titulo_lap = 'Laplaciano não aplicado';
        titulo_aguc = 'Aguçamento não aplicado';
    end

    sobel_x = fspecial('sobel');
    sobel_y = sobel_x';
    gx = imfilter(img_cinza, sobel_x, 'replicate');
    gy = imfilter(img_cinza, sobel_y, 'replicate');
    img_sobel = sqrt(gx.^2 + gy.^2);
    img_sobel = mat2gray(img_sobel);

    figure('Name', sprintf('Prática 03 - %s', rotulos{i}), 'Position', [100, 100, 1400, 700]);
    subplot(2, 3, 1); imshow(img_cinza, []); title(sprintf('Original - %s', rotulos{i}));
    subplot(2, 3, 2); imshow(img_media, []); title(sprintf('Média %dx%d', kernel_media, kernel_media));
    subplot(2, 3, 3); imshow(img_mediana, []); title(sprintf('Mediana %dx%d', kernel_mediana, kernel_mediana));
    subplot(2, 3, 4); imshow(img_laplaciano, []); title(titulo_lap);
    subplot(2, 3, 5); imshow(img_agucada, []); title(titulo_aguc);
    subplot(2, 3, 6); imshow(img_sobel, []); title('Sobel (bordas)');

    variancia_original = var(img_cinza(:));
    variancia_media = var(img_media(:));
    variancia_mediana = var(img_mediana(:));
    energia_bordas = mean(img_sobel(:));

    fprintf('\n=== %s (%s) ===\n', rotulos{i}, arquivos{i});
    fprintf('Variância original: %.6f\n', variancia_original);
    fprintf('Variância pós-média: %.6f\n', variancia_media);
    fprintf('Variância pós-mediana: %.6f\n', variancia_mediana);
    fprintf('Energia média de bordas (Sobel): %.6f\n', energia_bordas);
end

fprintf('\nResumo esperado da análise visual:\n');
fprintf('- Média: reduz ruído, mas tende a borrar bordas.\n');
fprintf('- Mediana: melhor para ruído impulsivo, preserva melhor contornos.\n');
fprintf('- Laplaciano: destaca variações rápidas de intensidade.\n');
fprintf('- Sobel: evidencia bordas e estruturas anatômicas.\n');