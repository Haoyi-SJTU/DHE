% Plots a colormap based on a real-valued matrix, visually representing the magnitude 
% of the matrix elements using a rich variety of colors and shapes.
% This function is open-sourced in https://blog.csdn.net/zzx2016zzx/article/details/80635840
% input:
%          'FigShape' --- Sets the shape of the color blocks; possible values ​​are:
%                'Square'  --- Square (default)
%                'Ellipse' --- Ellipse
%          'FigSize' --- Sets the size of the color blocks; possible values ​​are:
%                'Full'    --- Maximum size (default)
%                'Auto'    --- Automatically determines block size based on matrix element values
%          'FillStyle' --- Sets the fill style for the color blocks; possible values ​​are:
%                'Fill'    --- Fills the interior of the blocks (default)
%                'NoFill'  --- Does not fill the interior of the blocks
%          'DisplayOpt' --- Sets whether to display the matrix element values ​​within the blocks; possible values ​​are:
%                'On'      --- Displays matrix element values ​​(default)
%                'Off'     --- Does not display matrix element values
%          'TextColor' --- Sets the color of the text; possible values ​​are:
%                Single-character codes for colors ('r', 'g', 'b', 'y', 'm', 'c', 'w', 'k'); defaults to black
%                A 1x3 vector of RGB grayscale values ​​([r, g, b])
%                'Auto'    --- Automatically determines text color based on matrix element values
%          'ColorBar' --- Sets whether to display a color bar; possible values ​​are:
%                'On'      --- Displays the color bar
%                'Off'     --- Does not display the color bar (default)
%          'Grid' --- Sets whether to display grid lines; possible values ​​are:
%                'On'      --- Displays grid lines (default)
%                'Off'     --- Does not display grid lines
function matrixplot(data,varargin)

[FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor,~, YVarNames,ColorBar,GridOpt] = parseInputs(varargin{:});

[m,n] = size(data);
[x,y] = meshgrid(0:n,0:m);
data = data(:);
maxdata = nanmax(data);
mindata = nanmin(data);
rangedata = maxdata - mindata;
if isnan(rangedata)
    warning('MATLAB:warning1','请检查您输入的矩阵是否合适！');
    return;
end
z = zeros(size(x))+0.2;
sx = x(1:end-1,1:end-1)+0.5;
sy = y(1:end-1,1:end-1)+0.5;

sx = sx(:);
sy = sy(:);
id = isnan(sx) | isnan(data);
sx(id) = [];
sy(id) = [];
data(id) = [];

figure('color','w','units','normalized','pos',[1.38, 0.13, 0.53, 0.37]);
axes('units','normalized');%,'pos',[0.1,0.022,0.89,0.85]);
set(gca, 'Fontname', 'Times New Roman','FontSize',12);


if strncmpi(GridOpt,'On',2)
    mesh(x,y,z, 'EdgeColor',[0.7,0.7,0.7], 'FaceAlpha',0, 'LineWidth',0.5);   
end
hold on;


set(gca,'Ytick',(1:m)-0.5,...
    'YtickLabel',YVarNames,...
    'YDir','reverse',...
    'Ycolor',[0.7,0.7,0.7], 'TickLength',[0,0]);
axis off

if strncmpi(FillStyle,'Fill',3)
    MyPatch(sx',sy',data',FigShape,FigSize);
end

if strncmpi(DisplayOpt,'On',2)
    str = num2str(data,'%4.2f');
    scale = 0.1*max(n/m,1)/(max(m,n)^0.55);
    if strncmpi(TextColor,'Auto',3)
        ColorMat = get(gcf,'ColorMap');
        nc = size(ColorMat,1);
        cid = fix(mapminmax(data',0,1)*nc)+1;
        cid(cid<1) = 1;
        cid(cid>nc) = nc;
        TextColor = ColorMat(cid,:);
        for i = 1:numel(data)
            text(sx(i),sy(i),0.1,str(i,:), 'FontUnits','normalized', 'FontSize',scale,...
                'fontweight','bold','HorizontalAlignment','center', 'Color',TextColor(i,:));
        end
    else
        text(sx,sy,0.1*ones(size(sx)),str, 'FontUnits','normalized', 'FontSize',scale,...
            'fontweight','bold', 'HorizontalAlignment','center', 'Color',TextColor);
    end
end

axes(gca);
xstr = {'0','50','100','150','200','250'}; %X轴字符串
xtick = [0,50,100,150,200,250];
xl = xlim(gca);


ystr = {'span\{\alpha1,\beta1\}', 'span\{\alpha2,\beta2\}', 'span\{\alpha3,\beta3\}', ...
        'span\{\alpha4,\beta4\}', 'span\{\alpha5,\beta5\}', 'span\{\alpha6,\beta6\}', ...
        'span\{\alpha7,\beta7\}', 'span\{\alpha8,\beta8\}', 'span\{\alpha9,\beta9\}', ...
        'span\{\alpha10,\beta10\}', 'span\{\alpha11,\beta11\}', 'span\{\alpha12,\beta12\}'};
ytick = get(gca,'YTick');
yl = ylim(gca);

set(gca,'XTickLabel',[],'YTickLabel',[]);

x = zeros(size(ytick)) + xl(1) - range(xl)/50;
y = zeros(size(xtick)) + yl(2) + range(yl)/30;
set(gca, 'Fontname', 'Times New Roman','FontSize',12);
text(xtick,y, xstr, 'Interpreter', 'tex',  'FontSize',12, 'Fontname', 'Times New Roman', 'HorizontalAlignment','left');
text(x,ytick, ystr, 'interpreter', 'tex',  'FontSize',12, 'Fontname', 'Times New Roman', 'HorizontalAlignment','right');
text((xtick(3)+xtick(4))/2,y(1)+0.6, 'time series', 'FontSize',12, 'Fontname', 'Times New Roman','HorizontalAlignment','left');


if strncmpi(ColorBar,'On',2)
    c = colorbar('Direction','reverse');%'Location','East',
    c.Position = [0.82,0.105,0.0197,0.82];
    bar_pos = get(c, 'position');
    ylabel(c,'IE''s Area','Rotation',90,'Position',[bar_pos(1)+60*bar_pos(3), bar_pos(1)+40*bar_pos(3)]);
end
end

