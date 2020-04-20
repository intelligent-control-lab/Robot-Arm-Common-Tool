clear
robot=robotproperty('GP50');

%% read the weld point information
load('weld.mat');


for i = 1:size(planes,1)
    if planes(i,3) == -1
        x1 = 0:0.05:1.026;
%         x1 = 1.3:0.05:1.5+1.026;
        y1 = -0.205:0.05:0.205;
        [x, y] = meshgrid(x1,y1);
        z = planes(i,1)*x + planes(i,2)*y + planes(i,4);
    end
    if planes(i,2) == -1
        x1 = 0:0.05:1.026;
%         x1 = 1.3:0.05:1.5+1.026;
        z1 = 0:0.02:0.3;
%         z1 = 0.7:0.02:0.3;
        [x, z] = meshgrid(x1,z1);
        y = planes(i,1)*x + planes(i,3)*z + planes(i,4);
    end   
    % transform the plane to real setup 
    [x,y,z] = rotatePlane(x,y,z,M1);
    xs = [xs {x}];
    ys = [ys {y}];
    zs = [zs {z}];
end

% modify the DH parameters 
modify = [0;-pi/4;pi/4;0;pi/4;0];
robot.DH(:,1) = robot.DH(:,1) + modify;
M=CapPos(robot);
clf; hold on;
robotCAD = load(strcat('figure/',robot.name,'.mat'));
% robotCAD = load(strcat('figure/workpiece.mat'));
switch robot.name
    case 'M16iB'
        scale = 1/1000;
    case 'LRMate200iD7L'
        scale = 1/1000;
    otherwise
        scale = 1;
end

% workpiece
for i=1:numel(robotCAD.workpiece)
    f=robotCAD.workpiece{i}.f; v=robotCAD.workpiece{i}.v.*scale; c=robotCAD.workpiece{i}.c; 
    color=[240,246,245]/255;
%     for j=1:size(v,1) 
%         v(j,:) = v(j,:) + [1.2,0,0];
%     end
    handle.workpiece(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

hold on
plot3(weld(:,1),weld(:,2),weld(:,3),'*-');

% xlim=[-1,4];
% ylim=[-1,1];
% zlim=[0,2];
view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
% wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[zlim(1),zlim(1),zlim(1),zlim(1)],[63,64,64]/255);
% wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
% wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[63,64,64]/255);
zlabel('z axis');
ylabel('y axis');
xlabel('x axis');