% Calculate the coordinates of the color block vertices and plot 
% the ellipse color block.

function EllipseVertices(x,y,z,a,b)
t = linspace(0,2*pi,30)';
m = numel(t);
t0 = -sign(z)*pi/4;
t0 = repmat(t0,[m,1]);
x0 = cos(t)*a;
y0 = sin(t)*b;
Xp = repmat(x,[m,1]) + x0.*cos(t0) - y0.*sin(t0);
Yp = repmat(y,[m,1]) + x0.*sin(t0) + y0.*cos(t0);
Zp = repmat(z,[m,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end