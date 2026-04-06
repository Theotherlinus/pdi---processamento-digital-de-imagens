%livia_maia_claudio 222050030%
pkg load image;

img1 = imread('flying.jpg');
img2 = imread('clips.png');

figure;
subplot(2,2,1); imshow(img1);
subplot(2,2,2); imhist(img1);
subplot(2,2,3); imshow(img2);
subplot(2,2,4); imhist(img2);

T0 = 50;
T1 = 140;

img1L = img1 < T0;
img2L = img2 > T1;

figure;
subplot(1,2,1); imshow(img1L);
subplot(1,2,2); imshow(img2L);

img1bw = im2bw(img1, 50/255);
img2bw = im2bw(img2, 140/255);

figure;
subplot(1,2,1); imshow(img1bw);
subplot(1,2,2); imshow(img2bw);

T2 = 50;
T3 = 80;

img1r = img1 > T2 & img1 < T3;
img2r = img2 > T2 & img2 < T3;

figure;
subplot(1,2,1); imshow(img1r);
subplot(1,2,2); imshow(img2r);

rice = imread('rice.png');

figure;
imshow(rice);

rice_25 = im2bw(rice, 0.25);
rice_55 = im2bw(rice, 0.55);

figure;
subplot(1,2,1); imshow(rice_25); title('T = 0.25');
subplot(1,2,2); imshow(rice_55); title('T = 0.55');


T_otsu = graythresh(rice, 'otsu');
rice_otsu = im2bw(rice, T_otsu);

T_iso = graythresh(rice, 'intermeans');
rice_iso = im2bw(rice, T_iso);

figure;
subplot(1,3,1); imshow(rice);
subplot(1,3,2); imshow(rice_otsu);
subplot(1,3,3); imshow(rice_iso);


