%livia_maia_claudio 222050030%

pkg load image;

% FASE 01
imagem01 = imread('Y10R.jpg');
imagem02 = imread('mdb022.png');
imagem03 = imread('M_104.jpg');
imagem04 = imread('10.png');
imagem05 = imread('distal_fracture1.jpg');

imagens = {imagem01, imagem02, imagem03, imagem04, imagem05};
% FASE 02
figure('Name', 'Filtros de Suavização (Média e Mediana)');
h = ones(3,3) / 9;
for i = 1:length(imagens)
    img = imagens{i};

    % Filtro da média
    J = imfilter(img, h, 'replicate');
    J = im2uint8(J);

    % Filtro da mediana
    K = medfilt2(img, [3,3]);

    subplot(length(imagens), 3, (i-1)*3 + 1), imshow(img), title(['Original ', num2str(i)]);
    subplot(length(imagens), 3, (i-1)*3 + 2), imshow(J), title('Média 3x3');
    subplot(length(imagens), 3, (i-1)*3 + 3), imshow(K), title('Mediana 3x3');
end

% FASE 02 - FILTROS DE AGUÇAMENTO (REALCE DE DETALHES)
% Laplaciano
laplacian = [0 -1 0; -1 4 -1; 0 -1 0];

figure('Name', 'Filtro Laplaciano e Realce');
for i = 1:length(imagens)
    img = imagens{i};

    L = imfilter(double(img), laplacian, 'replicate');
    L_vis = im2uint8(mat2gray(abs(L)));
    realce = im2uint8(mat2gray(double(img) - L));

    subplot(length(imagens), 3, (i-1)*3 + 1), imshow(img), title(['Original ', num2str(i)]);
    subplot(length(imagens), 3, (i-1)*3 + 2), imshow(L_vis), title('Laplaciano');
    subplot(length(imagens), 3, (i-1)*3 + 3), imshow(realce), title('Realçada');
end

% Sobel
figure('Name', 'Detecção de Bordas - Sobel');
h_sobel = fspecial("sobel");

for i = 1:length(imagens)
    img = imagens{i};

    Ix_s = filter2(h_sobel, double(img));
    Iy_s = filter2(h_sobel', double(img));
    I_sobel = sqrt(Ix_s.^2 + Iy_s.^2);
    I_sobel = uint8(255 * mat2gray(I_sobel));

    subplot(length(imagens), 2, (i-1)*2 + 1), imshow(img), title(['Original ', num2str(i)]);
    subplot(length(imagens), 2, (i-1)*2 + 2), imshow(I_sobel), title('Bordas - Sobel');
end

% FASE 03
disp("O filtro da média reduziu ruído e suavizou bordas, equanto o mediano manteve melhor as bordas e removeu ruídos isolados.");
disp("O filtro Laplaciano realçou detalhes e contornos.");
disp("O filtro Sobel destacou bordas fortes e transições bruscas, principalmente na imagem 3.");

