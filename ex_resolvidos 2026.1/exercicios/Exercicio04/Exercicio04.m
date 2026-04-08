%livia_maia_claudio 222050030%
pkg load image;

% EXERCICIO 04
% Filtros passa-alta, Robert, Prewitt, Sobel, Laplaciano e realce de bordas.

baseDir = fileparts(mfilename('fullpath'));
lenaPath = fullfile(baseDir, '..', '..', 'praticas', 'pratica_01', 'lenaCor.bmp');

% EXERCICIO 01
I = imread(lenaPath);
I = rgb2gray(I);

hp = [-1 -1 -1; -1 8 -1; -1 -1 -1];
J1 = filter2(hp, I);
J1 = uint8(J1);

figure;
subplot(1,2,1), imshow(I), title('Original - Lena');
subplot(1,2,2), imshow(J1, []), title('Filtro passa-alta');

% EXERCICIO 02
Robert = [1 0; 0 -1];
J2 = filter2(Robert, I);
J2 = uint8(J2);

figure;
subplot(1,2,1), imshow(I), title('Original - Lena');
subplot(1,2,2), imshow(J2, []), title('Filtro de Robert');

% EXERCICIO 03
h_prewitt = fspecial('prewitt');
Ix_p = filter2(h_prewitt, I);
Iy_p = filter2(h_prewitt', I);
I_prewitt = sqrt(Ix_p.^2 + Iy_p.^2);
I_prewitt = uint8(255 * mat2gray(I_prewitt));

h_sobel = fspecial('sobel');
Ix_s = filter2(h_sobel, I);
Iy_s = filter2(h_sobel', I);
I_sobel = sqrt(Ix_s.^2 + Iy_s.^2);
I_sobel = uint8(255 * mat2gray(I_sobel));

figure;
subplot(1,3,1), imshow(I), title('Original em cinza');
subplot(1,3,2), imshow(I_prewitt), title('Bordas - Prewitt');
subplot(1,3,3), imshow(I_sobel), title('Bordas - Sobel');

% EXERCICIO 04
img = imread('cameraman.tif');

g = fspecial('gaussian', [3,3], 1.5);
imgFiltrado = imfilter(img, g, 'replicate');

filtro_laplaciano = [0 1 0; 1 -4 1; 0 1 0];
bordas = imfilter(imgFiltrado, filtro_laplaciano, 'replicate');
img_realcada = im2uint8(mat2gray(double(imgFiltrado) - double(bordas)));

figure;
subplot(1,3,1), imshow(img), title('Original');
subplot(1,3,2), imshow(imgFiltrado), title('Levemente borrada');
subplot(1,3,3), imshow(img_realcada), title('Realce com Laplaciano');

% EXERCICIO 05
filtro_sobel_x = fspecial('sobel');
bordas_sobel = imfilter(img, filtro_sobel_x, 'replicate');
img_aguçada3 = img + 0.3 * abs(bordas_sobel);
img_aguçada3 = im2uint8(mat2gray(img_aguçada3));

figure;
subplot(1,3,1), imshow(img), title('Original');
subplot(1,3,2), imshow(abs(bordas_sobel), []), title('Bordas com Sobel');
subplot(1,3,3), imshow(img_aguçada3), title('Imagem aguçada');

% Quanto maior a máscara, mais borrada a imagem tende a ficar.