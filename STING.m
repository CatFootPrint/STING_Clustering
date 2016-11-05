function [L,center,number_of_cluster] = STING(X,Y,GRID,DENSITY,NEIGHBOR,MINPTS,varargin)
%STING  a clustering algorithm based on grid.
%   Input:
%       X - a vector contains the x-coordinate of points;
%       Y - a vector contains the y-coordinate of points(same length as X);
%       GRID - grid numbers <1x2 double> or <1x1 double>,for the first
%       GRID(1) is row's number and GRID(2) is column's number, for another
%       the GRID is edge length of uint cell,{[]};
%       DENSITY - density threshould;
%       NEIGHBOR - neighbor of a pixel, {4}(4-conect) or 8(8-conect);
%       MINPTS - connected cell's number threshould(miniman cell number in
%       a cluster),{5};
%       varargin - optional inputs to specify the plot properties.
%   Output:
%       L - labeled image, the label makes clusters
%
%   Copyright 2012 Tang Jianbo, China.
%   This code may be freely used and distributed, so long as it maintains
%   this copyright line.
%   $Revision: 1.0 $     $Date: 2013/01/01 14:12:20 $
%
%   See also BWLABEL, SHOWGRID, SHOWIMG
%

%% Ĭ�ϲ���
if nargin<2||isempty(X)||isempty(Y)
    error('*** Not enough input arguments.');
end
if ~isvector(X)||~isvector(Y)
    error(['*** "',inputname(1),'","',inputname(2),'" should be vectors.']);
end
PointNums = length(X);
if PointNums~=length(Y)
    error(['*** "',inputname(1),'","',inputname(2),'" are not same length.']);
end
if nargin<4||isempty(DENSITY)
    DENSITY = 1;
end
A = (max(X)-min(X));
B = (max(Y)-min(Y));
% ��GRID����Ϊ[]ʱ�����þ��ȷֲ����й��ƣ�MODEΪ��Ԫ����״{'square'|...}
MODE = 'square'; 
if nargin<3||isempty(GRID)  
    switch lower(MODE)
        case {'square','s'}
            ratio = A/B;
            M = ceil((sqrt((ratio+1)^2+4*(ratio*(PointNums-1)))-(ratio+1))/2);
            N = ceil(M/ratio);
            GRID = [M, N];
            clear ratio rM cN;
        otherwise
            M = ceil(sqrt(PointNums)-1);
            N = M;
            GRID = [M, N];
            clear rM cN;
    end  
end
if nargin<5||isempty(NEIGHBOR)||~ismember(NEIGHBOR,[4,8])
    NEIGHBOR = 4;         % 4-���򣨼��ͼ���е���ͨ����
end
if nargin<6||isempty(MINPTS)
    MINPTS = 5;    % ��ͨ�����ڰ�������Ŀ����Сֵ��������Ϊ������
end

%% ����ɢ���դ��
IMG = showgrid(X,Y,GRID,varargin); % IMG: image data (pixel 0 are backgound);
IMG = img2bw(IMG, DENSITY); % ͼ���ֵ��(if vaule<DENSITY, set pixel 0, otherwise 1)
axis equal;
    grid on;
%% ������ͨ����
[L,Nums] = bwlabel(IMG, NEIGHBOR);
% disp(['   selected connect: ',num2str(NEIGHBOR),'-connected objects.']);
for i=1:Nums
    [r, c] = find(L==i);
    if length(r)<MINPTS
        L(r,c) = 0;
    end
    clear r c;
end
showimg(L);
title('Detected clusters with STING algorithm');
    axis equal;
    grid on;
idicator_pool=unique(L);
idicator_pool=idicator_pool(2:end);
number_of_cluster=numel(idicator_pool);
center=Inf*ones(number_of_cluster,2);
    for indicator=1:number_of_cluster
            [row_temp,column_temp,label_temp]=find(L==idicator_pool(indicator));
            center(indicator,:)=mean(([row_temp,column_temp]));
    end
end % // STING()

