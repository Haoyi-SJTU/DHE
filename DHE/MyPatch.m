%  Plotting a 3D colored patch map based on scattered data
%  x, y, and z are real-valued arrays specifying the 3D coordinates of the 
% patch centers. FigShape is a string variable specifying the shape of the 
% patches. xy represents the patch coordinates, and z represents the 
% corresponding values ​​for the patches. FigSize is a string variable 
% specifying the size of the patches.
% This function is open-sourced in https://blog.csdn.net/zzx2016zzx/article/details/80635840
% 
%Example：
%     x = rand(10,1);
%     y = rand(10,1);
%     z = rand(10,1);
%     MyPatch(x,y,z,'s','Auto');

function  MyPatch(x,y,z,FigShape,FigSize)  


if numel(x) ~= numel(z) || numel(y) ~= numel(z)
    error('The coordinates should be of equal length.');
end

if strncmpi(FigSize,'Auto',3) && ~strncmpi(FigShape,'Ellipse',1)
    id = (z == 0);
    x(id) = [];
    y(id) = [];
    z(id) = [];
end
if isempty(z)
    return;
end

rab1 = ones(size(z));
maxz = max(abs(z));
if maxz == 0
    maxz = 1;
end
rab2 = abs(z)/maxz;
if strncmpi(FigShape,'Square',1)
    if strncmpi(FigSize,'Full',3)
        r = rab1;
    else
        r = sqrt(rab2);
    end
    SquareVertices(x,y,z,r);
else
    a = 0.48 + rab2*(0.57-0.48);
    b = (1-rab2).*a;
    EllipseVertices(x,y,z,a,b);
end
end