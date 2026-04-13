% livia_maia_claudio 222050030
% Prática 03 - Filtros Espaciais em Imagens Médicas: Suavização e Realce

pkg load image;
close all;
clc;

base_dir = 'medicas';
saida_dir = 'resultados_pratica03';

if exist(saida_dir, 'dir') ~= 7
    mkdir(saida_dir);
end

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

    [~, nome_base, ~] = fileparts(arquivos{i});
    prefixo = sprintf('%02d_%s', i, nome_base);

    imwrite(img_cinza, fullfile(saida_dir, [prefixo '_01_original.png']));
    imwrite(img_media, fullfile(saida_dir, [prefixo '_02_media.png']));
    imwrite(img_mediana, fullfile(saida_dir, [prefixo '_03_mediana.png']));
    imwrite(img_laplaciano, fullfile(saida_dir, [prefixo '_04_laplaciano.png']));
    imwrite(img_agucada, fullfile(saida_dir, [prefixo '_05_agucamento.png']));
    imwrite(img_sobel, fullfile(saida_dir, [prefixo '_06_sobel.png']));

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

fprintf('\nImagens salvas em: %s\n', saida_dir);

fprintf('\nResumo esperado da análise visual:\n');
fprintf('- Média: reduz ruído, mas tende a borrar bordas.\n');
fprintf('- Mediana: melhor para ruído impulsivo, preserva melhor contornos.\n');
fprintf('- Laplaciano: destaca variações rápidas de intensidade.\n');
fprintf('- Sobel: evidencia bordas e estruturas anatômicas.\n');

fprintf('\n=== FASE 3: ANÁLISE COMPARATIVA (RESPOSTAS) ===\n');

fprintf('\nPergunta 1: O ruído foi reduzido adequadamente?\n');
fprintf('1) Mamografia: Sim, houve redução moderada de granulação sem descaracterizar a estrutura geral.\n');
fprintf('2) Tomografia: Sim, o ruído foi atenuado principalmente com mediana, com resultado visual mais limpo.\n');
fprintf('3) Ressonância (Cérebro): Sim, a suavização reduziu flutuações de intensidade em regiões homogêneas.\n');
fprintf('4) Raio-X (Fratura): Parcialmente, pois a imagem original já apresentava baixo ruído.\n');
fprintf('5) Imagem com Ruído: Sim, de forma clara; a mediana foi a que melhor removeu o ruído impulsivo.\n');

fprintf('\nPergunta 2: As bordas importantes foram preservadas?\n');
fprintf('1) Mamografia: Sim, as bordas principais foram preservadas, embora com leve suavização na média.\n');
fprintf('2) Tomografia: Parcialmente, contornos centrais se mantiveram, mas bordas finas perderam contraste.\n');
fprintf('3) Ressonância (Cérebro): Sim, as fronteiras anatômicas ficaram bem destacadas com Sobel.\n');
fprintf('4) Raio-X (Fratura): Parcialmente, o Sobel preserva as linhas mais fortes, mas estruturas sutis ficam menos nítidas.\n');
fprintf('5) Imagem com Ruído: Sim, após a mediana as bordas relevantes continuaram visíveis e mais estáveis.\n');

fprintf('\nPergunta 3: Houve perda de detalhes relevantes?\n');
fprintf('1) Mamografia: Houve perda leve de microdetalhes com média; mediana preservou melhor.\n');
fprintf('2) Tomografia: Houve perda leve a moderada em texturas finas nas regiões mais homogêneas.\n');
fprintf('3) Ressonância (Cérebro): Sim, a média removeu alguns detalhes finos; mediana manteve melhor definição.\n');
fprintf('4) Raio-X (Fratura): Perda baixa, mantendo os elementos principais para interpretação visual.\n');
fprintf('5) Imagem com Ruído: Houve perda moderada na média, mas a mediana apresentou melhor equilíbrio.\n');

fprintf('\nPergunta 4: A imagem ficou mais adequada para diagnóstico?\n');
fprintf('1) Mamografia: Sim, a imagem tratada ficou mais limpa para inspeção geral.\n');
fprintf('2) Tomografia: Sim, principalmente com mediana + sobel para apoiar leitura de contornos.\n');
fprintf('3) Ressonância (Cérebro): Sim, o pré-processamento melhorou contraste de estruturas sem comprometer a análise global.\n');
fprintf('4) Raio-X (Fratura): Parcialmente, útil para visualização geral, mas sempre comparando com a original.\n');
fprintf('5) Imagem com Ruído: Sim, foi a que mais ganhou qualidade diagnóstica após o processamento.\n');
