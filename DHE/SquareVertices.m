% Calculate the coordinates of the color block vertices and plot the 
% square color block.

function SquareVertices(x,y,z,r)

hx = r/2;
hy = hx;
Xp = [x-hx;x-hx;x+hx;x+hx;x-hx];%四个角的x坐标
Yp = [y-hy;y+hy;y+hy;y-hy;y-hy];%四个角的y坐标
Zp = repmat(z,[5,1]);
patch(Xp,Yp,Zp,'FaceColor','flat','EdgeColor','flat');
end