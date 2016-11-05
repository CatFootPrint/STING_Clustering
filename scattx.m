function scattx(DATA,IDX,Marker,MarkerSize,IsShowCenter)
%SCATTX   display point set clusters. 
%   Synatx:
%         SCATTX(DATA,IDX,Marker,MarkerSize,IsShowCenter)
%   Input:
%         DATA - dataset of format: [x y t case]
%         IDX  - cluster id of every event in data
%         Marker-makers to reprensent clusters
%         MarkerSize - marker size(default=6)
%         IsShowCenter - 'yes'(show  the clusters center),not otherwise
%   Output:
%         scatter figure
%
%   See also  SCATTER, MAPSHOW
%
%   Copyright 2012 Tang Jianbo, CSU. 
%   This code may be freely used and distributed, so long as it maintains
%   this copyright line.
%   Version 1.0, Date 2012-10-20 20:10:00.
  
if(nargin<1)
    error('  Not enough input arguments.');
end
[Row,Col] = size(DATA);
if((Row==1)&&(Col>Row))
    % DATA是一维行向量
    DATA=DATA';
end
if((Row==2)&&(Col>Row))
    % DATA是行向排列的二维矩阵
    DATA=DATA';
end
if((Row==3)&&(Col>Row))
    % DATA是行向排列的三维矩阵
    DATA=DATA';
end
[NLines,dim] = size(DATA);
if(nargin<2||isempty(IDX))
    IDX=zeros(NLines,1);
else
    IDX=IDX(:);
    if(NLines~=size(IDX,1))
        error(['"',inputname(1),'" and "',inputname(2),'" are not same length.']);
    end
end
if(nargin<3||isempty(Marker))
    Marker={'ro','bo','go','mo','co',...
            'rs','bs','gs','ms','cs',...
            'r^','b^','g^','m^','c^',...
            'r*','b*','g*','m*','c*',...
            'rx','bx','gx','mx','cx',...
            'r+','b+','g+','m+','c+',...
            'rp','bp','gp','mp','cp',...
            'rd','bd','gd','md','cd',...
            'rv','bv','gv','mv','cv',...
            'r<','b<','g<','m<','c<',...
            'r>','b>','g>','m>','c>',...
            'r.','b.','g.','m.','c.',...
            'rh','bh','gh','mh','ch'};  % // 5*13=65 type
    NoiseMaker = {'k.'};
else
    NoiseMaker = Marker(1);
    Marker(1) = [];
end
if(nargin<4||isempty(MarkerSize))
    MarkerSize=6; % default
end
if(nargin<5||isempty(IsShowCenter))
    IsShowCenter='no';% 'yes'
end

colorkind=length(Marker);
% cluster
EventsIDs=(1:NLines)';
NoiseInd=(IDX==0);
NoiseIX=EventsIDs(NoiseInd);
CoreIX=IDX(~NoiseInd);
ClusterIDs = unique(CoreIX(:));
ClusterNums = length(ClusterIDs);
clear NoiseInd CoreIX;
% BL=(length(Marker)==1)||(length(Marker)<ClusterNums);
BL=(length(Marker)<ClusterNums);
if(BL)
    Colors=hsv(ClusterNums);
    Ind =randperm(ClusterNums);
    Colors = Colors(Ind',:);
    NoiseMaker = {'k.'};
end

% plot figure
hold on;
switch(lower(IsShowCenter))
    case {'on','yes','y',1}
        if(dim==1)
            % 一维散点图
            plot(NoiseIX,DATA(NoiseIX),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);
                % BL=(length(Marker)==1)||(length(Marker)<ClusterNums);
                if(BL)
                    plot(X,DATA(X),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot(X,DATA(X),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
                Cx=mean(X);
                Cy=mean(DATA(X));
                % plot(Cx,Cy,'k+','MarkerSize',8);
                text(Cx,Cy,num2str(i));
                % legend(h,'cluster center');
                hold on;                
            end
        elseif(dim==2)
            % 二维散点图
            plot(DATA(NoiseIX,1),DATA(NoiseIX,2),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);
                if(BL)
                    % Colors=hsv(ClusterNums);
                    plot(DATA(X,1),DATA(X,2),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot(DATA(X,1),DATA(X,2),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
                Cx=mean(DATA(X,1));
                Cy=mean(DATA(X,2));
                % plot(Cx,Cy,'k+','MarkerSize',8);
                text(Cx,Cy,num2str(i));
                % legend(h,'cluster center');
                hold on;
            end            
        elseif(dim>=3)
            % 三维散点图
            plot3(DATA(NoiseIX,1),DATA(NoiseIX,2),DATA(NoiseIX,3),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);
                % BL=(length(Marker)==1)||(length(Marker)<ClusterNums);
                if(BL)
                    % Colors=hsv(ClusterNums);
                    plot3(DATA(X,1),DATA(X,2),DATA(X,3),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot3(DATA(X,1),DATA(X,2),DATA(X,3),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
                Cx=mean(DATA(X,1));
                Cy=mean(DATA(X,2));
                Cz=mean(DATA(X,3));
                % plot3(Cx,Cy,Cz,'k+','MarkerSize',8);
                text(Cx,Cy,Cz,num2str(i));
                % legend(h,'cluster center');
                hold on;
            end
            % grid on;
            box on;   
            % view(-20,28);
            % zlabel('Time');
        else
            error('   The first paramter is not suit.');
        end % if
    otherwise
        if(dim==1)
            % 一维散点图
            plot(NoiseIX,DATA(NoiseIX),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);
                % BL=(length(Marker)==1)||(length(Marker)<ClusterNums);
                if(BL)
                    plot(X,DATA(X),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot(X,DATA(X),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
            end
        elseif(dim==2)
            % 二维散点图
            plot(DATA(NoiseIX,1),DATA(NoiseIX,2),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);                
                if(BL)
                    % Colors=hsv(ClusterNums);
                    plot(DATA(X,1),DATA(X,2),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot(DATA(X,1),DATA(X,2),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
            end
        elseif(dim>=3)
            % 三维散点图
            plot3(DATA(NoiseIX,1),DATA(NoiseIX,2),DATA(NoiseIX,3),NoiseMaker{1},'MarkerSize',MarkerSize);
            hold on;
            for i=1:ClusterNums
                Ind=(IDX==ClusterIDs(i));
                X=EventsIDs(Ind);               
                % BL=(length(Marker)==1)||(length(Marker)<ClusterNums);
                if(BL)
                    % Colors=hsv(ClusterNums);
                    plot3(DATA(X,1),DATA(X,2),DATA(X,3),Marker{1},'MarkerSize',MarkerSize,'Color',Colors(i,:));
                else
                    cid = rem(i,colorkind);
                    if(cid==0)
                        cid=colorkind;
                    end
                    plot3(DATA(X,1),DATA(X,2),DATA(X,3),Marker{cid},'MarkerSize',MarkerSize);
                end
                hold on;
            end
            % grid on;
            box on;
            % view(-20,28);
            % zlabel('Time');
        else
            error('  The first paramter is not suit.');
        end % if        
end % switch()
% 
% xlabel('X');
% ylabel('Y');
box on;
hold off;
% end function here
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END SCATTEX()

