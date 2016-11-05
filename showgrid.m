function Img = showgrid(X,Y,GRID,varargin)
%SHOWGRID   convert a scatter point dataset into a grid raster image.
%   Input:
%       X - a vector contains the x-coordinate of points;
%       Y - a vector contains the y-coordinate of points(same length as X);
%       GRID - grid numbers <1x2 double> or <1x1 double>,for the first
%       GRID(1) is row's number and GRID(2) is column's number, for another
%       the GRID is edge length of uint cell.
%       varargin - optional inputs to specify the plot properties.
%   Output:
%       Img - image data (pixel 0 are backgound);
%
%   Copyright 2012 Tang Jianbo, China.
%   This code may be freely used and distributed, so long as it maintains
%   this copyright line.
%   $Revision: 1.0 $     $Date: 2013/01/01 14:12:20 $
%
%   See also BWLABEL, SHOWGRID, SHOWIMG
%

%% 默认参数
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

A = (max(X)-min(X));
B = (max(Y)-min(Y));
% 当GRID参数为[]时，采用均匀分布进行估计，MODE为单元格形状{'square'|...}
MODE = 'square'; 
if nargin<3||isempty(GRID)
    switch lower(MODE)
        case {'square','s'}
            ratio = A/B;
            M = ceil((sqrt((ratio+1)^2+4*(ratio*(PointNums-1)))-(ratio+1))/2);
            N = ceil(M/ratio);
            GRID = [M, N];
            clear ratio M N;
        otherwise 
            M = ceil(sqrt(PointNums)-1);
            N = M;
            GRID = [M, N];
            clear M N;
    end
end
if nargin<4||isempty(varargin)
    varargin = {'Color','b'};
end

%% 离散点集栅格化--计算格网划分
if length(GRID)==1
    % GRID： edge length of uint cell<1x1 double>
    gridLength = GRID(1);
    GRID(1) = ceil(A/gridLength);
    GRID(2) = ceil(B/gridLength);
    clear gridLength;
end
% GRID： numbers of rows and columns used to tesselation the point
% dataset filed<1x2 scalar>
detaX = A/GRID(1);
detaY = B/GRID(2);
clear A B;
XX = (min(X)-detaX):detaX:(max(X)+detaX);
YY = (min(Y)-detaY):detaY:(max(Y)+detaY);

%% 统计各个单元格的点数
Img = zeros(length(YY)-1, length(XX)-1); % 图像向左右和上下方向分别扩展了一个网格
for i=1:PointNums
    m = ceil((X(i)-XX(1))/detaX);
    n = ceil((Y(i)-YY(1))/detaY);
    Img(n,m) = Img(n,m)+1;
end


%% 绘制网格
hold on;
% 水平格线
for i=1:length(YY)
    plot([min(XX); max(XX)],[YY(i); YY(i)]);
end
% 垂直格线
for j=1:length(XX)
    plot([XX(j); XX(j)],[min(YY); max(YY)]);
end
scattx([X(:),Y(:)]);
% 设置范围
offset = min(detaX*3, detaY*3);
axis([min(XX)-offset, max(XX)+offset, min(YY)-offset, max(YY)+offset]);

end % // showgrid()

