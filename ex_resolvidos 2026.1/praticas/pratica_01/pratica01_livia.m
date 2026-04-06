%livia_maia_claudio 222050030%
% pratica 01 - operacoes aritmeticas e logicas em imagens

pkg load image;
close all; clear all; clc;

% exercicio 01 e 02
a = zeros(300,300);
a(25:175,125:175) = 1;

b = zeros(300,300);
b(125:175,25:175) = 1;

c = zeros(300,300);
c(150:300,150:300) = 1;

figure('name', 'exercicio 01 e 02');
subplot(1,3,1), imshow(a), title('imagem a');
subplot(1,3,2), imshow(b), title('imagem b');
subplot(1,3,3), imshow(c), title('imagem c');

% exercicio 03: soma
soma_ab = a + b;
soma_ac = a + c;
soma_bc = b + c;

figure('name', 'exercicio 03 - somas');
subplot(2,3,1), imshow(a), title('a');
subplot(2,3,2), imshow(b), title('b');
subplot(2,3,3), imshow(c), title('c');
subplot(2,3,4), imshow(soma_ab), title('a + b');
subplot(2,3,5), imshow(soma_ac), title('a + c');
subplot(2,3,6), imshow(soma_bc), title('b + c');

disp('--- exercicio 03 ---');
disp('a ordem nao altera o resultado. na intersecao ocorre 1+1=2, como passa de 1 o imshow mostra branco.');

% exercicio 04: subtracao
sub_ab = a - b;
sub_ba = b - a;
sub_ac = a - c;
sub_bc = b - c;

figure('name', 'exercicio 04 - subtracoes');
subplot(2,3,1), imshow(a), title('a');
subplot(2,3,2), imshow(b), title('b');
subplot(2,3,3), imshow(sub_ab), title('a - b');
subplot(2,3,4), imshow(sub_ba), title('b - a');
subplot(2,3,5), imshow(sub_ac), title('a - c');
subplot(2,3,6), imshow(sub_bc), title('b - c');

disp('--- exercicio 04 ---');
disp('a ordem altera os resultados. na intersecao (1-1=0) a area fica preta.');

% exercicio 05: multiplicacao
mult_ab = a .* b;
mult_ac = a .* c;
mult_bc = b .* c;

figure('name', 'exercicio 05 - multiplicacoes');
subplot(2,3,1), imshow(a), title('a');
subplot(2,3,2), imshow(b), title('b');
subplot(2,3,3), imshow(c), title('c');
subplot(2,3,4), imshow(mult_ab), title('a .* b');
subplot(2,3,5), imshow(mult_ac), title('a .* c');
subplot(2,3,6), imshow(mult_bc), title('b .* c');

disp('--- exercicio 05 ---');
disp('a ordem nao altera. funciona como um AND logico, so a intersecao fica branca.');

% exercicio 06: divisao
warning('off', 'Octave:divide-by-zero'); 
div_ab = a ./ b;
div_ba = b ./ a;
div_ac = a ./ c;

figure('name', 'exercicio 06 - divisoes');
subplot(2,3,1), imshow(a), title('a');
subplot(2,3,2), imshow(b), title('b');
subplot(2,3,3), imshow(c), title('c');
subplot(2,3,4), imshow(div_ab), title('a ./ b');
subplot(2,3,5), imshow(div_ba), title('b ./ a');
subplot(2,3,6), imshow(div_ac), title('a ./ c');

disp('--- exercicio 06 ---');
disp('a ordem altera bastante. divisao por zero gera infinito ou nan.');
warning('on', 'Octave:divide-by-zero');

% exercicio 07
img_lena = imread('lenaCor.bmp');

canal_1 = img_lena(:,:,1);

[linhas, colunas, canais] = size(img_lena);
disp('--- exercicio 07 ---');
fprintf('tamanho da imagem lena: %d linhas, %d colunas, %d canais.\n', linhas, colunas, canais);

img_cortada = img_lena(51:end-50, 51:end-50, :);

img_cinza = (double(img_lena(:,:,1)) + double(img_lena(:,:,2)) + double(img_lena(:,:,3))) / 3;
img_cinza = uint8(img_cinza);

figure('name', 'exercicio 07 - lena');
subplot(2,2,1), imshow(img_lena), title('1. original');
subplot(2,2,2), imshow(canal_1), title('2. canal vermelho');
subplot(2,2,3), imshow(img_cortada), title('4. cortada');
subplot(2,2,4), imshow(img_cinza), title('5. cinza (media)');