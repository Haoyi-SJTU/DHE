% Subfunction for parsing input parameters

function [FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor, XVarNames,YVarNames,ColorBar,GridOpt] = parseInputs(varargin)

if mod(nargin,2)~=0
    error('Incorrect number of input parameters; they must appear in pairs.');
end
pnames = {'FigShape','FigSize','FigStyle','FillStyle','DisplayOpt',...
    'TextColor','XVarNames','YVarNames','ColorBar','Grid'};
dflts =  {'Square','Full','Auto','Fill','On','k','','','Off','On'};
[FigShape,FigSize,FigStyle,FillStyle,DisplayOpt,TextColor,XVarNames,...
    YVarNames,ColorBar,GridOpt] = parseArgs(pnames, dflts, varargin{:});

validateattributes(FigShape,{'char'},{'nonempty'},mfilename,'FigShape');
validateattributes(FigSize,{'char'},{'nonempty'},mfilename,'FigSize');
validateattributes(FigStyle,{'char'},{'nonempty'},mfilename,'FigStyle');
validateattributes(FillStyle,{'char'},{'nonempty'},mfilename,'FillStyle');
validateattributes(DisplayOpt,{'char'},{'nonempty'},mfilename,'DisplayOpt');
validateattributes(TextColor,{'char','numeric'},{'nonempty'},mfilename,'TextColor');
validateattributes(XVarNames,{'char','cell'},{},mfilename,'XVarNames');
validateattributes(YVarNames,{'char','cell'},{},mfilename,'YVarNames');
validateattributes(ColorBar,{'char'},{'nonempty'},mfilename,'ColorBar');
validateattributes(GridOpt,{'char'},{'nonempty'},mfilename,'Grid');
if ~any(strncmpi(FigShape,{'Square','Circle','Ellipse','Hexagon','Dial'},1))
    error('The shape parameter must be one of: Square, Circle, Ellipse, Hexagon, Dial.');
end
if ~any(strncmpi(FigSize,{'Full','Auto'},3))
    error('The figure size parameter must be one of: Full, Auto.');
end
if ~any(strncmpi(FigStyle,{'Auto','Tril','Triu'},4))
    error('The figure style parameter must be one of: Auto, Tril, Triu.');
end
if ~any(strncmpi(FillStyle,{'Fill','NoFill'},3))
    error('The figure fill style parameter must be one of: Fill, NoFill.');
end
if ~any(strncmpi(DisplayOpt,{'On','Off'},2))
    error('The display values ​​parameter must be one of: On, Off.');
end
if ~any(strncmpi(ColorBar,{'On','Off'},2))
    error('The color bar display parameter must be one of: On, Off.');
end
if ~any(strncmpi(GridOpt,{'On','Off'},2))
    error('The grid display parameter must be one of: On, Off.');
end
end