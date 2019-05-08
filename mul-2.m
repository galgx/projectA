clear;
clc;
close all;

pkg load communications

v1 = linspace(0,1,100);
v2 = linspace(0,1,100);
v3 = v1'*v2;
v4 = zeros(100);

x = round(v3.*2^19);
b = de2bi(x, 19, 2, 'left-msb');
d = bi2de(b(:,1:8), 2, 'left-msb');
v4 = reshape(d/2^8,[100,100]);

figure();
subplot(1,2,1);
imshow(v3,[]);
title('befor the round');
subplot(1,2,2);
imshow(v4,[]);
title('after the round');
