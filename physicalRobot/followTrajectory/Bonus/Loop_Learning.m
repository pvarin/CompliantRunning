close all; clear all; clc;

figure(7);
hold on
axis equal
axis([-.15 .2 -.25 .0]);

h_des = plot([0],[0],'k--');
h_des.XData=[];
h_des.YData=[];

iter = 30;
col = colormap(parula(iter));
col = flipud(col);

for i = 1:iter
    eval(sprintf('h_foot_%g = plot([0],[0]);',i));
    eval(sprintf('h_foot_%g.XData=[];',i));
    eval(sprintf('h_foot_%g.YData=[];',i));
end

pts_dcur1 = zeros(1,13);
pts_dcur2 = zeros(1,13);

for i = 1:iter
    [t,x,y,xdes,ydes,pts_dcur1,pts_dcur2] = Iterative_Feedfoward_Learning(pts_dcur1,pts_dcur2);

    if i == 1
        h_des.XData = xdes;
        h_des.YData = ydes;
    end

    eval(sprintf('set(h_foot_%g,''Color'',col(%g,:));',i,i));
    eval(sprintf('h_foot_%g.XData = x;',i));
    eval(sprintf('h_foot_%g.YData = y;',i));
    
end
