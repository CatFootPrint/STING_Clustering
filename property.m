function structArray = property(cellVector)
%PROPERTY    convert a cell vector to a new struct array
%   STRUCTARRAY=PROPERTY(CELLVECTOR)  cellVector is a cell vector, and
%   returns a new struct structArray.
%   for example, there is a cell vector,we want to convert it to a struct
%   as a input pramter, such as,
%   cell:
%       {'Color','b','LineWidth',1,'LineStyle','-'}
%   struct:
%       structArray.Color = 'b';
%       structArray.LineWidth = 1;
%       structArray.LineStyle = '-';
%   Example:
%     % we want to define a function which uses 'plot' inner, we want to
%     % specfiy its innput arguments to let 'plot' more flexiable.
%     varargin = {'color','b','linestyle','-.','linewidth',2};
%     prop = property(varargin);
%     plot(sin(-pi:0.1:pi), prop);
%     % thus we can get a figure with property define with 'varargin'.
%
%   See also CELL2STRCUT
%   $ Copyright 2012 Tang Jianbo $. This code may be freely used and
%   distributed, so long as it maintains this copyright line.

if nargin<1||isempty(cellVector)
    error('*** Not enough input arguments.');
end
if ~isvector(cellVector)
    error(['*** "',inputname(1),'" must be a vector.']);
end
propNums = length(cellVector);
if mod(propNums,2)~=0
    error(['*** "',inputname(1),'" must be a vector of length 2N(N>=1).']);
end

% To rule the value on the even index of cellVector be 'PropertyName', and 
% the odd index be the 'PropertyValue'. 
propNameIndex = 1:2:propNums;
propName = cellVector(propNameIndex);    % fields
clear propNameIndex;
propValueIndex= 2:2:propNums;
propValue = cellVector(propValueIndex);  % values
clear propValueIndex;

% create a new struct array
if length(propName)~=length(propValue)
    error('*** Input arguments is not suitable.');
end
for i=1:length(propName)
    structArray.(propName{i}) = propValue{i};
end
% structArray = p;
end % // property()


