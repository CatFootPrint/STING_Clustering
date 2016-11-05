% compute the kth spatial/temporal distance
function output = kdist(data,k,option)
% INPUT:
%    data -- spatial data;
%    k(minpts) -- minimal number of points in eps-neighbor;
%    option -- distance order,'ascend'|'descend'.
% OUPUT:
%    output -- <struct>
%
if nargin<2
    error('*** Not enough input arguments.');
end
if nargin<3
    option = 'descend';
end
[entynums,attnums]=size(data);
switch lower(option)
    case {'ascend','asc','a',1}
    otherwise
        option = 'descend';
end
if(attnums==2)
    % 二维空间数据
    Sdist = zeros(entynums,1);    
    for indx=1:entynums
        % Kth spatial distance
        spatial_dis = distx(data(indx,1:2),data(:,1:2));
        spatial_dis = sort(spatial_dis);
        if(length(spatial_dis)<(k+1))
            Sdist(indx) = inf;
        else
            Sdist(indx) = spatial_dis(k+1);
        end
    end    
    % distance plot
    Sdist = sort(Sdist,option);
    figure;
    plot(Sdist,'k','LineWidth',2);
    xlabel('Point number');
    ylabel(['Nearest neighbor distance (k=',num2str(k),')']);
    % set(gca,'xlim',[0,round(entynums*1.1)]);
    box off;
    % output
    output.k_dist=Sdist;
elseif attnums==3
    % 三位空间数据
    Sdist = zeros(entynums,1);
    Tdist = zeros(entynums,1);    
    for indx=1:entynums
        % Kth spatial distance
        spatial_dis = distx(data(indx,1:2),data(:,1:2));
        spatial_dis = sort(spatial_dis);
        if(length(spatial_dis)<(k+1))
            Sdist(indx) = inf;
        else
            Sdist(indx) = spatial_dis(k+1);
        end
        % Kth temporal distance
        temporal_dis = distx(data(indx,3),data(:,3));
        temporal_dis = sort(temporal_dis);
        if(length(temporal_dis)<(k+1))
            Tdist(indx) = inf;
        else
            Tdist(indx) = temporal_dis(k+1);
        end
    end    
    % distance plot
    Sdist = sort(Sdist,option);
    figure;
    plot(Sdist,'k','LineWidth',2);
    xlabel('Point number');
    ylabel(strcat(num2str(k),'th nearest spatial distance'));
    % set(gca,'xlim',[0,round(entynums*1.1)]);
    box off;
    Tdist = sort(Tdist,option);
    figure;
    plot(Tdist,'k','LineWidth',2);
    xlabel('Point number');
    ylabel(strcat(num2str(k),'th nearest temporal distance'));
    % set(gca,'xlim',[0,round(entynums*1.1)]);
    box off;
    % output
    output.spatial_k_dist=Sdist;
    output.temporal_kdist=Tdist;
else
    error('*** this function only support 2 or 3 dimentions.');
end
end  % function end

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function D=distx(X,Set)
[m,n]=size(Set);
if(n==1)
    D=abs(ones(m,1)*X-Set);
elseif(n>1)
    D=sqrt(sum((ones(m,1)*X-Set).^2,2));
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
