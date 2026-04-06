% Primeiro programa no octave

clear all % limpa todas as variaveis da memória
close all % fecha todas as figuras
clc % limpa a tela

%Criando variaveis
a = 2
b = 3
c = a * b

%Criando matrizes
d = [10.50 25.10;5.89 9.14]

%convertendo para inteiro
e = uint8(d)
%int = inteiro
%u = unsigned = sem sinal = positivo
%8 = 8 bits = 0 - 255

%Antes da operacao aritmetica, retornar para double
f = double(e) / 2

%somatorio
g = sum(e) %soma linha
h = sum(e') %soma coluna
i = sum(sum(e)) %soma matriz
h= sum(e(:))

%manipulando vetores
v = [1 2 3 4 5]
v1 = v(2) %segundo elemento do vetores
v2 = v(2:4) % elementos do intervalo de 2 a 4
v3 = v(:) %vetor coluna

%manipulando matrizes
m = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16]
m1 = m(3,4) % elemento linha 3 coluna 4
m2 = m(2,:) % linha 2
m3 = m(:,2) % coluna 2
m4 = m(2:4,3) %elementos da linhas de 2 a 4 e coluna 3
m5 = m(2:4,:) %elementos de 2 a 4 de todas as colunas

%modificando matriz
v(5) = []
m(3,:) = v
m(3,:) =[]









