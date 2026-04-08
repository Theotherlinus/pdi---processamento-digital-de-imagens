clear all % limpa todas as variaveis da memoria
close all % fecha todas as figuras
clc % limpa a tela
pkg load image
cd('/home/jesuliana/Documentos/UFSJ/PDI/Banco_Imagens');

imgGray = imread('lena_gray.bmp');
##figure,imshow(imgGray);
##title('Imagem Lena');
##whos imgGray
##
##%Apenas o numero de linhas
##size (imgGray,1)
##%Apenas o numero de colunas
##size (imgGray,2)
##
##%Pixel da posicao 10,10
##imgGray10 = imgGray (10,10);
##display("Pixel 10");
##disp(imgGray10);

%Pixel contidos no intervalo linha 10 coluna 10
##imgGrayIntervalo = imgGray(1:10, 1:10);
##display("\nLinha 1 a 10 e Coluna 1 a 10 ");
##disp(imgGrayIntervalo);
##
##%alterando a imagem
##imgGray(1:20,1:20) = 0;
##figure,imshow(imgGray);title('Imagem Lena');
##imwrite (imgGray, "lenaAlterado.jpeg")

%lena colorida
imgCor = imread('lenaCor.bmp');
figure,imshow(imgCor);title('Imagem Lena');

whos img

R = imgCor(:,:,1);
G = imgCor(:,:,2);
B = imgCor(:,:,3);

figure,imshow([R G B]);
figure, imshow(R); title('Vermelha');
figure, imshow(G); title('Verde');
figure, imshow(B); title('Azul');

imgCorCat = cat(3, R,G,B);
figure, imshow(imgCorCat);

imgGrayTamanho = imresize(imgGray,0.5);
figure, imshow(imgGrayTamanho);








