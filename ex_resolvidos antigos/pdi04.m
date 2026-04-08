%livia_maia_claudio 222050030%
pkg load image;
%EXERCÍCIO 01
I = imread("galaxy.jpg");

h = ones(3,3)/9;
J = filter2(h,I);
J = uint8(J);

K = medfilt2(I, [3,3]);

figure;

subplot(3,2,1), imshow(I), title('Original');
subplot(3,2,2), imhist(I), title('Histograma Original');
subplot(3,2,3), imshow(J), title('Filtragem pela média');
subplot(3,2,4), imhist(J), title('Histograma Média');
subplot(3,2,5), imshow(K), title('Filtragem mediana 3x3');
subplot(3,2,6), imhist(K), title('Histograma Mediana');

%A filtragem média deixa a imagem mais bonita e suave, enquanto a mediana preserva bem melhor as bordas.

%EXERCÍCIO 02
L = imnoise(I, 'salt & pepper');

w = ones(3,3)/9;
M = filter2(w,L);
M = uint8(M);
N = medfilt2(L, [3,3]);
figure;
subplot(3,2,1), imshow(L), title('Original');
subplot(3,2,2), imhist(L), title('Histograma Original');
subplot(3,2,3), imshow(M), title('Filtragem pela média');
subplot(3,2,4), imhist(M), title('Histograma Média');
subplot(3,2,5), imshow(N), title('Filtragem mediana 3x3');
subplot(3,2,6), imhist(N), title('Histograma Mediana');

%A filtragem pela mediana tirou melhor o ruído e tambem deixou a imagem mais borrada.
%O filtro da mediana preservou melhor as bordas e seria o que eu recomendaria para esse tipo de ruído.
%EXERCÍCIO 03
p = imread("peppers.png");
p = rgb2gray(p);

r = ones(3,3)/9;
S = filter2(r,p);
S = uint8(S);
T = medfilt2(p, [3,3]);
figure;
subplot(4,2,1), imshow(p), title('Original');
subplot(4,2,2), imhist(p), title('Histograma Original');
subplot(4,2,3), imshow(S), title('Filtragem pela média');
subplot(4,2,4), imhist(S), title('Histograma Média');
subplot(4,2,5), imshow(T), title('Filtragem mediana 3x3');
subplot(4,2,6), imhist(T), title('Histograma Mediana');

A = imnoise(p, 'salt & pepper');

b = ones(3,3)/9;
C = filter2(b,A);
C = uint8(C);
D = medfilt2(A, [3,3]);
figure;
subplot(3,2,1), imshow(A), title('Original');
subplot(3,2,2), imhist(A), title('Histograma Original');
subplot(3,2,3), imshow(C), title('Filtragem pela média');
subplot(3,2,4), imhist(C), title('Histograma Média');
subplot(3,2,5), imshow(D), title('Filtragem mediana 3x3');
subplot(3,2,6), imhist(D), title('Histograma Mediana');

%EXERCÍCIO 04
%quanto maior a máscara, mais borrada a imagem ficou.
