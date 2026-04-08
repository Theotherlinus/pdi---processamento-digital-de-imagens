clear all % limpa todas as variaveis da memoria
close all % fecha todas as figuras
clc % limpa a tela
pkg load image;

img1  = imread('lenna.png');
img2  = imread('rice.png');
img3  = imread('palhaco.bmp');
k = histeq(img1);
figure;
subplot(2,2,1); imshow(img1);
subplot(2,2,2); hist(img1);
subplot(2,2,3); imshow(k);
subplot(2,2,4); hist(k);

k = histeq(img2);
figure;
subplot(2,2,1); imshow(img2);
subplot(2,2,2); hist(img2);
subplot(2,2,3); imshow(k);
subplot(2,2,4); hist(k);

k = histeq(img3);
figure;
subplot(2,2,1); imshow(img3);
subplot(2,2,2); hist(img3);
subplot(2,2,3); imshow(k);
subplot(2,2,4); hist(k);

k = histeq(img1,16);
figure;
subplot(2,2,1); imshow(img1);
subplot(2,2,2); hist(img1);
subplot(2,2,3); imshow(k);
subplot(2,2,4); hist(k);
