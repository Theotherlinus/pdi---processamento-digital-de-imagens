clc all;
close all;
clear all;


F=imread('baboon.png');
figure, imshow(F);

[largura, altura] = size(F);

mosaico = zeros(128,128,16);
imMosaico = zeros(512,512);
contl = 1;
posicao = 1;
lli = 1;
while contl <= 4
   lls = lli + 127;
   lci = 1;
   contc = 1;
   while contc <= 4
      lcs = lci + 127;
        mosaico(:,:,posicao) = F(lli:lls,lci:lcs);
      lci = lci + 128;
      contc = contc + 1;
      posicao = posicao + 1;
   endwhile
      contl = contl + 1;
      lli = lli + 128;
endwhile  



imMosaico(1:128,1:128) = mosaico(:,:,6); 
imMosaico(1:128,129:256) = mosaico(:,:,11); 
imMosaico(1:128,257:384) = mosaico(:,:,13); 
imMosaico(1:128,385: 512) = mosaico(:,:,3); 

imMosaico(129:256,1:128) = mosaico(:,:,8); 
imMosaico(129:256,129:256) = mosaico(:,:,16); 
imMosaico(129:256,257:384) = mosaico(:,:,1); 
imMosaico(129:256,385: 512) = mosaico(:,:,9); 

imMosaico(257:384,1:128) = mosaico(:,:,12); 
imMosaico(257:384,129:256) = mosaico(:,:,14); 
imMosaico(257:384,257:384) = mosaico(:,:,2); 
imMosaico(257:384,385: 512) = mosaico(:,:,7); 

imMosaico(385: 512,1:128) = mosaico(:,:,4); 
imMosaico(385: 512,129:256) = mosaico(:,:,15); 
imMosaico(385: 512,257:384) = mosaico(:,:,10); 
imMosaico(385: 512,385:512) = mosaico(:,:,5); 


figure, imshow(uint8(imMosaico));

