clear;
close all;
% function STING_DEMO()
% % Input the data
load('./Data/recover_128QAM.mat');
% load('./Data/recover_8PSK.mat');
% load('./Data/recover_16PSK.mat');
% load('./Data/record_256QAM_-19dBm.mat');
% load('./Data/recover_128QAM_-19dBm_2.mat');
% load('./Data/recover_16QAM.mat');
signal_recover=signal_recover/(max(max(abs(signal_recover))));
DATA=[real(signal_recover),imag(signal_recover)];

% Parameters Initialization
X = DATA(:,1);   % X-coordinate
Y = DATA(:,2);   % Y-coordinate
GRID = [];       % grid division parameter. If choose[], is means that we estimate the length of square throuth uniform distribution.
DENSITY =1;      % The threshold of points. Let a denotes the number of point locating in square A. If a<DENSITY, we do not select this square, otherwise, we select this square.
NEIGHBOR = 8;    % Choose 4 or 8. The number of neighbourhood we test.
MINPTS = 5;      % If the distance of two clusters is less than MINPTS, we combine these two clusters into a bigger one.

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
figure;scatter(center(:,1),center(:,2),'p');
axis equal;grid on;
% end % // STING demo
%END OF PROGRA

