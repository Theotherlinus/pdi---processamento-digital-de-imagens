%livia_maia_claudio 222050030%

pkg load image;

imagem01 = imread('Y10R.jpg');
imagem02 = imread('mdb022.png');
imagem03 = imread('M_104.jpg');
imagem04 = imread('10.png');
imagem05 = imread('distal_fracture1.jpg');

imagens = {imagem01, imagem02, imagem03, imagem04, imagem05};

figure('Position', [100, 100, 1400, 1000]);

for i = 1:length(imagens)
    img = imagens{i};
    img = im2double(img);

    F = fft2(img);
    magnitude = abs(F);
    fase = angle(F);
    magnitude_centralizada = fftshift(magnitude);

    subplot(length(imagens), 5, (i-1)*5 + 1);
    imshow(img);
    title(sprintf('Imagem %d Original', i));

    subplot(length(imagens), 5, (i-1)*5 + 2);
    imshow(log(1 + magnitude_centralizada), []);
    title(sprintf('Img %d - Espectro', i));
    colorbar;

    subplot(length(imagens), 5, (i-1)*5 + 3);
    imshow(fase, []);
    title(sprintf('Img %d - Fase', i));
    colorbar;

    subplot(length(imagens), 5, (i-1)*5 + 4);
    [m, n] = size(magnitude_centralizada);
    centro_y = floor(m/2) + 1;
    centro_x = floor(n/2) + 1;

    [X, Y] = meshgrid(1:n, 1:m);
    distancia_centro = sqrt((X - centro_x).^2 + (Y - centro_y).^2);

    raio_baixas = min(m,n) * 0.15;
    mascara_baixas = distancia_centro <= raio_baixas;
    mascara_altas = ~mascara_baixas;

    imagem_regioes = zeros(m, n, 3);
    imagem_regioes(:,:,1) = mascara_baixas;
    imagem_regioes(:,:,2) = mascara_altas;
    imshow(imagem_regioes);
    title(sprintf('Img %d - Regiões Freq', i));

    subplot(length(imagens), 5, (i-1)*5 + 5);
    espectro_baixas = magnitude_centralizada .* mascara_baixas;
    espectro_altas = magnitude_centralizada .* mascara_altas;

    imshow([log(1 + espectro_baixas), log(1 + espectro_altas)], []);
end

D0 = 50;
n_butter = 2;

for i = 1:length(imagens)
  img = imagens{i};
  img = im2double(img);

 [m, n] = size(img);
    [X, Y] = meshgrid(1:n, 1:m);
    centro_x = floor(n/2);
    centro_y = floor(m/2);
    D = sqrt((X - centro_x).^2 + (Y - centro_y).^2);

    % Transformada de Fourier
    F = fft2(img);
    F_shift = fftshift(F);

    % Filtros passa-baixas
    H_ideal_pb = double(D <= D0);
    H_gauss_pb = exp(-(D.^2) / (2*(D0^2)));
    H_butter_pb = 1 ./ (1 + (D./D0).^(2*n_butter));

    % Filtros passa-altas
    H_ideal_pa = double(D > D0);
    H_gauss_pa = 1 - H_gauss_pb;
    H_butter_pa = 1 - H_butter_pb;

    % Aplicar filtros
    G_ideal_pb = F_shift .* H_ideal_pb;
    G_gauss_pb = F_shift .* H_gauss_pb;
    G_butter_pb = F_shift .* H_butter_pb;

    G_ideal_pa = F_shift .* H_ideal_pa;
    G_gauss_pa = F_shift .* H_gauss_pa;
    G_butter_pa = F_shift .* H_butter_pa;

    % Transformada Inversa
    img_ideal_pb = real(ifft2(ifftshift(G_ideal_pb)));
    img_gauss_pb = real(ifft2(ifftshift(G_gauss_pb)));
    img_butter_pb = real(ifft2(ifftshift(G_butter_pb)));

    img_ideal_pa = real(ifft2(ifftshift(G_ideal_pa)));
    img_gauss_pa = real(ifft2(ifftshift(G_gauss_pa)));
    img_butter_pa = real(ifft2(ifftshift(G_butter_pa)));

    % Exibir resultados
    base = (i - 1) * 7; % 7 colunas por imagem
    subplot(length(imagens), 7, base + 1); imshow(img, []); title(sprintf('Imagem %d Original', i));
    subplot(length(imagens), 7, base + 2); imshow(img_ideal_pb, []); title('Ideal PB');
    subplot(length(imagens), 7, base + 3); imshow(img_gauss_pb, []); title('Gaussiano PB');
    subplot(length(imagens), 7, base + 4); imshow(img_butter_pb, []); title('Butterworth PB');
    subplot(length(imagens), 7, base + 5); imshow(img_ideal_pa, []); title('Ideal PA');
    subplot(length(imagens), 7, base + 6); imshow(img_gauss_pa, []); title('Gaussiano PA');
    subplot(length(imagens), 7, base + 7); imshow(img_butter_pa, []); title('Butterworth PA');
end
