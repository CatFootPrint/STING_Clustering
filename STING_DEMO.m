clear;
close all;
% save('./Result/center_128QAM.mat','center');save('./Result/cluster_128QAM.mat','L');
% function STING_DEMO()
% % Input the data
% load('./Data/PSK_8_0_complex.mat');
% load('./Data/PSK_8_4_complex.mat');
% load('./Data/PSK_8_5_complex.mat');
% load('./Data/PSK_8_7_complex.mat');
% load('./Data/PSK_8_8_complex.mat');
% load('./Data/PSK_8_9_complex.mat');
% load('./Data/PSK_8_10_complex.mat');
% load('./Data/PSK_8_11_complex.mat');
% load('./Data/PSK_8_13_complex.mat');
% %==========================================================
% load('./Data/PSK_16_1_complex.mat');
% load('./Data/PSK_16_2_complex.mat');
% load('./Data/PSK_16_6_complex.mat');
% load('./Data/PSK_16_7_complex.mat');
% load('./Data/PSK_16_14_complex.mat');
% load('./Data/PSK_16_19_complex.mat');
% load('./Data/PSK_16_21_complex.mat');
% load('./Data/PSK_16_22_complex.mat');
% %==========================================================
% load('./Data/QAM_16_2_complex.mat');
% load('./Data/QAM_16_10_complex.mat');
% load('./Data/QAM_16_11_complex.mat');
% load('./Data/QAM_16_15_complex.mat');
load('./Data/QAM_16_17_complex.mat');
% %==========================================================
% load('./Data/QAM_32_3_complex.mat');
% %==========================================================
% load('./Data/QAM_128_7_complex.mat');
% load('./Data/QAM_128_14_complex.mat');
% %==========================================================
% load('./Data/QPSK_1_complex.mat');
% load('./Data/QPSK_2_complex.mat');
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
[~,center,~]=STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
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
% center=[real(center_complex),imag(center_complex)];
% %---------------------------------------------------------------------------------------------------------------
signal_recover=signal_recover*exp(-1i*phase);
DATA=[real(signal_recover),imag(signal_recover)];

% Parameters Initialization
X = DATA(:,1);   % X-coordinate
Y = DATA(:,2);   % Y-coordinate
GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
DENSITY =1.5;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
MINPTS = 6;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.

% STING CLUSTERING
figure;
[L,center,number_of_cluster]=STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,'Color','b','LineWidth',1,'LineStyle','-');
% %----------------------------------------------------------------------------------
title_string=['The number of clusters is ',num2str(number_of_cluster)];
figure;scatter(center(:,1),center(:,2),'p');
axis equal;grid on;
title(title_string);
disp(title_string);
% L_recover=po_recover(L,phase);
% end % // STING demo
%END OF PROGRA