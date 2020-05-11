clear
robot=robotproperty_detail('GP50');

% modify the DH parameters 
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
    handle.workpiece(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

%% auxiliary setting
view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
zlabel('z axis');
ylabel('y axis');
xlabel('x axis');