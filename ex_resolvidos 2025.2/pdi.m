%livia_maia_claudio 222050030%
pkg load image;

imagem  = imread("brain1.jpg");
imagem1 = imread("estrada1.jpg");
imagem1 = rgb2gray(imagem1);
imagem2 = imread("fogo.jpg");
imagem2 = rgb2gray(imagem2);


bright  = imagem  + 50;  bright(bright > 255)  = 255;
bright1 = imagem1 + 50;  bright1(bright1 > 255) = 255;
bright2 = imagem2 + 70;  bright2(bright2 > 255) = 255;
% Quanto maior o valor somado à imagem, mais claro ela fica. O valor limitado em 255 é para não dar overflow e estourar a capacidade de uint8.


mult = bright * 1.5; mult(mult > 255) = 255;
figure;
imshow(mult);
mult1 = bright1 * 1.5; mult1(mult1 > 255) = 255;
figure;
imshow(mult1);
mult2 = bright2 * 1.0; mult2(mult2 > 255) = 255;
figure;
imshow(mult2);
% A multiplicação aumentou o contraste da imagem, o que facilita a leitura de documentos com letras pouco visíveis.

imgdif1 = imread("paramecio.jpg");
imgdif2 = imread("paramecio1.jpg");
diff = abs(imgdif1 - imgdif2);

mask = diff > 0;
imshow(mask);
title("Diferenças");
% Foi detectado as diferenças de pixel entre as imagens. Sim, diferenças mínimas podem aparecer devido a ruído da câmera, compressão JPEG ou alteração de iluminação.

%Considerações finais:
%O uso de operações aritméticas alteram a intensidade e brilho da imagem.
%Já as operações lógicas Permitem identificar regiões específicas, como pixels que mudaram ou objetos com certa intensidade, o que facilita destacar ou filtrar áreas de interesse.
%Essas técnicas podem ser utilizadas em processamento de fotografias, melhoria na resolução de imagens médicas, detecção de movimentos em câmeras de seguraça etc.

