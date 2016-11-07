clear;
close all;
% function STING_DEMO()
% % Input the data
% load('./Data/recover_128QAM.mat');
% load('./Data/recover_8PSK.mat');
% load('./Data/recover_16PSK.mat');
% load('./Data/record_256QAM_-19dBm.mat');
% load('./Data/recover_128QAM_-19dBm_2.mat');
% load('./Data/recover_16QAM.mat');
% %==========================================================
load('./Data/recover_PSK_8_-25dBm_0.mat');
% load('./Data/recover_PSK_8_-25dBm_2.mat');%Fail
% load('./Data/recover_PSK_8_-30dBm_0.mat');%Fail
% load('./Data/recover_PSK_8_-30dBm_1.mat');
% load('./Data/recover_PSK_8_-30dBm_2.mat');
% %==========================================================
% load('./Data/recover_16PSK.mat');
% load('./Data/recover_PSK_16_-20dBm_1.mat');
% load('./Data/recover_PSK_16_-21dBm_1.mat');
% load('./Data/recover_PSK_16_-21dBm_2.mat');%Fail
% load('./Data/recover_PSK_16_-22dBm_1.mat');%Fail
% load('./Data/recover_PSK_16_-22dBm_2.mat');%Fail
% load('./Data/recover_PSK_16_-23dBm_1.mat');%Fail
% load('./Data/recover_PSK_16_-25dBm_0.mat');%Fail
% load('./Data/recover_PSK_16_-25dBm_1.mat');%Fail
% load('./Data/recover_PSK_16_-28dBm.mat');%Fail
% load('./Data/recover_PSK_16_-28dBm_1.mat');%Fail
% load('./Data/recover_PSK_16_-28dBm_2.mat');%Fail
% load('./Data/recover_PSK_16_-30dBm.mat');%Fail
% load('./Data/recover_PSK_16_-30dBm_1.mat');%Fail
% load('./Data/recover_PSK_16_-30dBm_2.mat');%Fail
% %==========================================================
load('./Data/recover_16QAM.mat');
% load('./Data/recover_QAM_16_-22dBm_0.mat');%Fail
% load('./Data/recover_QAM_16_-22dBm_1.mat');%Fail
% load('./Data/recover_QAM_16_-22dBm_2.mat');%Fail
% %==========================================================
% load('./Data/recover_QAM_32_-22dBm_0.mat');%Fail
% load('./Data/recover_QAM_32_-22dBm_-1.mat');%Fail
% %==========================================================
% load('./Data/recover_QAM_64_-19dBm_1.mat');%Fail
% %==========================================================
% load('./Data/recover_QAM_128_-19dBm_1.mat');%Fail
% load('./Data/recover_QAM_128_-19dBm_2.mat');%Fail
% load('./Data/recover_QAM_128_-22dBm_0.mat');%Fail
% load('./Data/recover_QAM_128_-22dBm_1.mat');%Fail
% load('./Data/recover_QAM_128_-22dBm_2.mat');%Fail
% load('./Data/recover_QAM_128_-30dBm_0.mat');
% load('./Data/recover_QAM_128_-30dBm_1.mat');%Fail
% load('./Data/recover_QAM_128_-30dBm_2.mat');%Fail
% load('./Data/recover_QAM_128_-30dBm_-1.mat');%Fail
% load('./Data/recover_QAM_128_-30dBm_-2.mat');
% %==========================================================
% load('./Data/recover_QAM_256_-20dBm_-1.mat');%Fail
% %==========================================================
% load('./Data/recover_QPSK_-30dBm.mat');%Cannot classify through STING.
% load('./Data/recover_QPSK_-30dBm-1.mat');
% load('./Data/recover_QPSK_-30dBm-2.mat');
%==========================================================
signal_recover=signal_recover/(max(max(abs(signal_recover))));
DATA=[real(signal_recover),imag(signal_recover)];

% Parameters Initialization
X = DATA(:,1);   % X-coordinate
Y = DATA(:,2);   % Y-coordinate
GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
DENSITY =1.5;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
MINPTS = 6;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.

% STING CLUSTERING
[L,center,number_of_cluster]=STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
% %---------------------------------------------------------------------------------------------------------------
% [X,Y]=find(L~=0);
% GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
% DENSITY =1;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
% NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
% MINPTS = 2;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.
% figure
% [L,center,number_of_cluster]=STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
% %---------------------------------------------------------------------------------------------------------------
% % %---------------------------------------------------------------------------------------------------------------
% [X,Y]=find(L~=0);
% GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
% DENSITY =1;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
% NEIGHBOR = 4;    % Choose 4 or 8. The number of neighbourhood we test.
% MINPTS = 2;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.
% figure
% [L,center,number_of_cluster]=STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
% % %---------------------------------------------------------------------------------------------------------------
center_complex=center*[1;1i];
phase=mean(angle(center_complex));
center_complex=center_complex*exp(-1i*phase);
center=[real(center_complex),imag(center_complex)];
% %---------------------------------------------------------------------------------------------------------------
title_string=['The number of clusters is ',num2str(number_of_cluster)];
figure;scatter(center(:,1),center(:,2),'p');
axis equal;grid on;
title(title_string);
disp(title_string);
% end % // STING demo
%END OF PROGRA

