%livia_maia_claudio 222050030%
pkg load image;

%Exemplo 01
a1 = ones(8);
fft2(a1);

%Exemplo 02
a2 = [100 200; 100 200];
a2 = repmat(a2, 4, 4);
fft2(a2);

%Exemplo 03
a3 = [zeros(8,4) ones(8,4)];
af3 = fft2(a3);
round(abs(af3))
af3s = fftshift(af3);
round(abs(af3s))

%Exemplo 04
a = [zeros(256,128) ones(256,128)];
af  = fftshift(fft2(a));
afl = abs(af);
figure, imshow(mat2gray(afl));

afl2 = log(1+abs(af));
figure, imshow(mat2gray(afl2));

%Exemplo 05
a = zeros(256,256);
a(78:178,78:178) = 1;
figure, imshow(a);

af = fftshift(fft2(a));
figure, imshow(mat2gray(log(1+abs(af))));

%Exemplo 06
[x,y] = meshgrid(1:256,1:256);
 b = (x+y<329)&(x+y>182)&(x-y>-67)&(x-y<73);
figure, imshow(b);
bf = fftshift(fft2(b));
figure, imshow(mat2gray(log(1+abs(bf))));

%Exemplo 07
[x,y] = meshgrid(-128:127,-128:127);
z = sqrt (x.^2 + y.^2);
c = (z<15);
figure, imshow(c);
 cf = fftshift(fft2(c));
figure, imshow(mat2gray(log(1+abs(cf))));

%Exemplo 8
cm = imread('cameraman.tif');
cf = fftshift(fft2(cm));
figure,
subplot(1,2,1); imshow(cm)
subplot(1,2,2); imshow(mat2gray(log(1+abs(cf))));
cfl = cf.*c;
% D0 = 15
[x,y] = meshgrid(-128:127,-128:127);
z = sqrt (x.^2 + y.^2);
c = (z<15);
cfl = cf.*c;
figure, imshow(mat2gray(log(1+abs(cfl))));
%Alterar
c = (z<5)
c = (z<30);
cfli = ifft2(cfl);
figure, imshow(mat2gray(abs(cfli)));

%Exemplo 09
c = (z>15);
cfh = cf.*c;
imshow(mat2gray(log(1+abs(cfh))));
 cfhi = ifft2(cfh);
imshow(mat2gray(abs(cfhi)));

%Exemplo 10
%D = 15 e ordem n = 2:
bl = 1./(1+((x.^2+y.^2)/15).^2);
cfbl = cf.*bl;
figure, imshow(mat2gray(log(1+abs(cfbl))));
figure, imshow(mat2gray(abs(ifft2(cfbl))));

%Exemplo 11
%D = 15 e ordem n = 2:
bh = 1 - 1./(1+((x.^2+y.^2)/15).^2);
cfbh = cf.*bh;
figure, imshow(mat2gray(log(1+abs(cfbh))));
figure, imshow(mat2gray(abs(ifft2(cfbh))));

%Exemplo 12
sigma = 10
g1 = mat2gray(fspecial('gaussian',256,10))
cfg1 = cf.*g1;
figure, imshow(mat2gray(log(1+abs(cfg1))));
figure, imshow(mat2gray(abs(ifft2(cfg1))));

%Exemplo 13
h1 = 1 -g1;
ch1 = cf.*h1;
figure, imshow(mat2gray(log(1+abs(ch1))));
figure, imshow(mat2gray(abs(ifft2(ch1))));

