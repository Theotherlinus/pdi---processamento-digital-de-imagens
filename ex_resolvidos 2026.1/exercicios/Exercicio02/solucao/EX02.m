clc all;
close all;
clear all;

pkg load image

%Exercício 02
im= imread('baboon.png');
figure, imshow(im);
%a
imB = double(im/255.0);
%b
gama = 1.5;
imB15 = im*exp(1/gama);
imB = im*exp(1/gama);
imB = im*exp(1/gama);
title('Gama 1,5');

gama = 2.5;
imB25 = uint8(imB);
figure, imshow(imB25);
title('Gama 2,5');

gama = 3.5;
imB35 = uint8(imB);
figure, imshow(imB35);
title('Gama 3,5');