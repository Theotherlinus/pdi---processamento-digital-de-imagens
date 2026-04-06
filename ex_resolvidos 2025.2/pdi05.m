%livia_maia_claudio 222050030%
pkg load image;
%EXERCÍCIO 01
I = imread("lenaCor.bmp");
I = rgb2gray(I);
hp = [-1 -1 -1, -1 8 -1, -1 -1 -1]
J1 = filter2(hp,I);
figure;
imshow(J1);

%EXERCÍCIO 02
Robert=[1 0, 0 -1];
J2 = filter2(I,Robert);
figure;
imshow(J2, []);

%EXERCÍCIO 03
h_prewitt = fspecial("prewitt");
Ix_p = filter2(h_prewitt, I);
Iy_p = filter2(h_prewitt', I);
I_prewitt = sqrt(Ix_p.^2 + Iy_p.^2);
I_prewitt = uint8(255 * mat2gray(I_prewitt));

h_sobel = fspecial("sobel");
Ix_s = filter2(h_sobel, I);
Iy_s = filter2(h_sobel', I);
I_sobel = sqrt(Ix_s.^2 + Iy_s.^2);
I_sobel = uint8(255 * mat2gray(I_sobel));
figure;
subplot(1,3,1), imshow(I), title("Original em cinza");
subplot(1,3,2), imshow(I_prewitt), title("Bordas - Prewitt");
subplot(1,3,3), imshow(I_sobel), title("Bordas - Sobel");

% Lista com todas as imagens
imagens = {imagem01, imagem02, imagem03, imagem04, imagem05};
nomes = {'Y10R', 'mdb022', 'M_104', '10', 'distal_fracture1'};

% Filtro Laplaciano
laplacian = [0 -1 0; -1 4 -1; 0 -1 0];

% Processar cada imagem
for i = 1:length(imagens)
    img = imagens{i};

    % Aplicar filtro Laplaciano
    L = imfilter(double(img), laplacian, 'replicate');

    % Converter para visualização
    L_vis = im2uint8(mat2gray(abs(L)));

    % Realce da imagem (agudização)
    realce = im2uint8(mat2gray(double(img) - L));

    % Mostrar resultados
    figure;
    subplot(1,3,1), imshow(img), title(['Original - ' nomes{i}]);
    subplot(1,3,2), imshow(L_vis), title(['Laplaciano - ' nomes{i}]);
    subplot(1,3,3), imshow(realce), title(['Realçada - ' nomes{i}]);
end
