%livia_maia_claudio 222050030%
pkg load image;

%Exercício 01
Origbwc = imread("circles.gif");
se = strel('disk',5,0);
Erosbw = imerode(Origbwc, se);
figure;
subplot(1,2,1); imshow(Origbwc)
subplot(1,2,2); imshow(Erosbw);

%Exercício 02
se1 = strel("square", 12);
Erose1 = imerode(Origbwc, se1);
figure;
subplot(1,3,1); imshow(Origbwc)
subplot(1,3,2); imshow(Erosbw);
subplot(1,3,3); imshow(Erose1)

%Exercício 03
Origbwct = imread("texto.png");
se2 = strel('line',11,90);
Dilatabw = imdilate(Origbwct,se2);
figure;
subplot(1,2,1); imshow(Origbwct);
subplot(1,2,2); imshow(Dilatabw);

%Exercício 04
Dilata2 = imdilate(Origbwc, se1);
figure;
subplot(1,2,1); imshow(Origbwc);
subplot(1,2,2); imshow(Dilata2);

%Exercício 05
Origbwcs = imread("snowflakes.png");
se3 = strel('disk', 3,0);
Openbw = imopen(Origbwcs,se3);
figure;
subplot(1,2,1); imshow(Origbwcs);
subplot(1,2,2); imshow(Openbw);

%Exercício 06
se4 = strel('disk',4,0);
Closbw = imclose(Origbwcs,se4);
figure;
subplot(1,2,1); imshow(Origbwcs);
subplot(1,2,2); imshow(Closbw);

%Exercício 07
Origbwcsa = imread("aneis.png");
ClosbwA = imclose(Origbwcsa,se4);
figure;
subplot(1,2,1); imshow(Origbwcsa);
subplot(1,2,2); imshow(ClosbwA);
