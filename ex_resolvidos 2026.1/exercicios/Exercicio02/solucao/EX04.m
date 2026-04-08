clc all;
close all;
clear all;


A=imread('baboon.png');
B=imread('butterfly.png');

figure, imshow(A); 
figure, imshow(B); 


imM = 0.2*double(A) + 0.8*double(B);
figure, imshow(uint8(imM)); 
imwrite(uint8(imM),"comb1.png");

imM = 0.5*double(A) + 0.5*double(B);
figure, imshow(uint8(imM)); 
imwrite(uint8(imM),"comb2.png");

imM = 0.8*double(A) + 0.2*double(B);
figure, imshow(uint8(imM)); 
imwrite(uint8(imM),"comb3.png");
