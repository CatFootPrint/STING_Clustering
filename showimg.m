function showimg(Img,MinValue,ColorMapName,ColorNums)
%SHOWIMG   show image using user defined colors(default backgound is white)
%   Input:
%        Img - image data;
%        MinValue - the value in X which less than MinValue will be set as
%        white color;
%        ColorMapName - reference "colormap" in Matlab;
%        ColorNums - color index numbers will be used.
%   output:
%        Image figure.
%
%   Copyright 2012 Tang Jianbo, China.
%   This code may be freely used and distributed, so long as it maintains
%   this copyright line.
%   $Revision: 1.0 $     $Date: 2013/01/01 14:12:20 $
%
%   See also IMAGE, IMAGESC, COLORMAP
%

if(nargin<2||(isempty(MinValue)))
    MinValue=min(min(Img));
end
if(nargin<3||(isempty(ColorMapName)))
    ColorMapName='jet';
end
if(nargin<4||(isempty(ColorNums)))
    ColorNums=256;
end
Siz=size(Img);
if((Siz(1)<=1)||(Siz(2)<=1)||(size(Siz,2)>2))
    error(' The paramter "X" in "Picture(X)", must be 2D matrix !');
end
Img(Img<=MinValue)=MinValue;
figure;
% 自定义调色板 colorMatrix
switch(ColorMapName)
    case 'jet'
        colorMatrix=colormap(jet(ColorNums));
    case 'hsv'
        colorMatrix=colormap(hsv(ColorNums));
    case 'hot'
        colorMatrix=colormap(hot(ColorNums));
    case 'cool'
        colorMatrix=colormap(cool(ColorNums));
    case 'spring'
        colorMatrix=colormap(spring(ColorNums));
    case 'summer'
        colorMatrix=colormap(summer(ColorNums));
    case 'autumn'
        colorMatrix=colormap(autumn(ColorNums));
    case 'winter'
        colorMatrix=colormap(winter(ColorNums));
    case 'gray'
        colorMatrix=colormap(gray(ColorNums));
    case 'bone'
        colorMatrix=colormap(bone(ColorNums));
    case 'copper'
        colorMatrix=colormap(copper(ColorNums));
    case 'pink'
        colorMatrix=colormap(pink(ColorNums));
    case 'lines'
        colorMatrix=colormap(lines(ColorNums));
    otherwise
        colorMatrix=colormap(jet(ColorNums));        
end

% 图像显示
colorMatrix(1,:)=[1 1 1];
imagesc(Img);
colormap(colorMatrix);
axis xy; % 以左下角为原点

% 恢复系统默认的调色板
h=figure;
colormap('default');
close(h);

end % // showimg()
