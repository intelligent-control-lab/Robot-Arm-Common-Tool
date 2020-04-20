clear
robot=robotproperty('GP50');
% modify the DH parameters 
modify = [0;-pi/5;pi/5;0;pi/5;pi/2];
robot.DH(:,1) = robot.DH(:,1) + modify;
M=CapPos(robot);
clf; hold on;
robotCAD = load(strcat('figure/',robot.name,'.mat'));
switch robot.name
    case 'M16iB'
        scale = 1/1000;
    case 'LRMate200iD7L'
        scale = 1/1000;
    otherwise
        scale = 1;
end

% base
for i=1:numel(robotCAD.base)
    f=robotCAD.base{i}.f; v=robotCAD.base{i}.v.*scale; c=robotCAD.base{i}.c; color=robotCAD.base{i}.color;
    for j=1:size(v,1) 
        v(j,:) = v(j,:) + [0,0,0];
    end
    v = setVertice(v,M{1});
    handle.base(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end
% Link
for i=1:6%length(robotCAD.link)
    v=robotCAD.link{i}.v.*scale; f=robotCAD.link{i}.f; c=robotCAD.link{i}.c; color=robotCAD.link{i}.color;
    v = setVertice(v,M{i+1});
%     v = FK(v,M{i+1}); 
%     v = v';
    handle.link(i) = patch('Faces',f,'Vertices',v,'FaceVertexCData',c,'FaceColor',color,'EdgeColor','None');
end

xlim=[-1,3];
ylim=[-1,2];
zlim=[0,3];
view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);
wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[zlim(1),zlim(1),zlim(1),zlim(1)],[0.5,0.5,0.5]);
wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[0,0.9,0.9]);
wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[0,0.9,0.9]);
zlabel('z axis');