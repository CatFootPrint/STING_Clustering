function BW = img2bw(IMG,MINVALUE)
%IMG2BW   convert a 2-D color or gray image to binary image.
%   Input:
%         IMG - color image;
%         MINVALUE - threshould(if value<MINVALUE,set pixel 0,otherwise 1)
%
%   Output:
%        BW - binary image
% 
if nargin<2||isempty(IMG)
    error('*** Not enough input arguments.');
end
BW = zeros(size(IMG));
BW(IMG>=MINVALUE)=1;
    
end % //img2bw()
