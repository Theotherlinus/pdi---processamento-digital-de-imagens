%livia_maia_claudio 222050030%
pkg load image;

imagem = imread("baboon.png");

imagem_negativa = 1 - imagem;

figure;
subplot(1,2,1), imshow(imagem), title('Original');
subplot(1,2,2), imshow(imagem_negativa), title('Negativa');

imagem_double = double(imagem) / 255;
imagem_ajustada = imagem_double.^(1.5);
imagem_ajustada_uint8 = uint8(imagem_ajustada * 255);

figure;
subplot(1,2,1), imshow(imagem), title('Original');
subplot(1,2,2), imshow(imagem_ajustada_uint8), title('A^{gama}');

imagem_crianca = imread("crianca.jpg");
img_double = double(imagem_crianca);

r_min = min(img_double(:));
r_max = max(img_double(:));


L_min = 0;
L_max = 255;


imagem_contraste = (img_double - r_min) * ((L_max - L_min) / (r_max - r_min)) + L_min;
imagem_B = uint8(imagem_contraste);

figure;
subplot(1,2,1), imshow(imagem_crianca), title('Original');
subplot(1,2,2), imshow(imagem_B), title('Com Contraste Ajustado');
