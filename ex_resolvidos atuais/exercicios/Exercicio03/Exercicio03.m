%livia_maia_claudio 222050030%
pkg load image;

% EXERCICIO 03
% Comparacao entre filtragem pela media e pela mediana usando a imagem peppers.

baseDir = fileparts(mfilename('fullpath'));
imgPath = fullfile(baseDir, 'imagens', 'peppers.png');

I = imread(imgPath);
I = rgb2gray(I);

% Filtro da media 3x3
h = ones(3,3) / 9;
J = filter2(h, I);
J = uint8(J);

% Filtro da mediana 3x3
K = medfilt2(I, [3,3]);

figure;
subplot(3,2,1), imshow(I), title('Original');
subplot(3,2,2), imhist(I), title('Histograma Original');
subplot(3,2,3), imshow(J), title('Filtragem pela media');
subplot(3,2,4), imhist(J), title('Histograma Media');
subplot(3,2,5), imshow(K), title('Filtragem mediana 3x3');
subplot(3,2,6), imhist(K), title('Histograma Mediana');

% A filtragem pela media suaviza mais a imagem, mas tende a borrar as bordas.
% A filtragem mediana remove melhor ruidos do tipo sal e pimenta e preserva bordas.

% Versao com ruido sal e pimenta para comparar os dois filtros
L = imnoise(I, 'salt & pepper');

M = filter2(h, L);
M = uint8(M);

N = medfilt2(L, [3,3]);

figure;
subplot(3,2,1), imshow(L), title('Original com ruido');
subplot(3,2,2), imhist(L), title('Histograma com ruido');
subplot(3,2,3), imshow(M), title('Filtragem pela media');
subplot(3,2,4), imhist(M), title('Histograma Media');
subplot(3,2,5), imshow(N), title('Filtragem mediana 3x3');
subplot(3,2,6), imhist(N), title('Histograma Mediana');

% Nesse caso, o filtro da mediana costuma apresentar o melhor resultado.