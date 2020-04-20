%% draw by loading capsules 
clear
robot=robotproperty('GP50');
modify = [0;0;0;0;0;0];
robot.DH(:,1) = robot.DH(:,1) + modify;
M=CapPos(robot);
clf; 
hold on;
valpha = 0.8;
color = [0,1,0];
load(strcat('figure/', robot.name, 'Capsules.mat'));
boundary = RoBoundary;
handle=[];
n=min([size(M,2), length(boundary)]);
for i=1:n
    if isfield(boundary{i}, "X")
        X=boundary{i}.X;
        Y=boundary{i}.Y;
        Z=boundary{i}.Z;
        kd=size(X,1);jd=size(X,2);
        for k=1:kd
            for j=1:jd
                newvec=[X(k,j),Y(k,j),Z(k,j)]*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)';
                X(k,j)=newvec(1);
                Y(k,j)=newvec(2);
                Z(k,j)=newvec(3);
            end
        end
        handle(i)=surf(X,Y,Z,'FaceColor',color,'EdgeColor','None');
        alpha(handle(i),valpha);
    end
end

view([1,-0.5,0.4]);
axis equal
axis([xlim,ylim,zlim]);
lighting=camlight('left');
%lighting phong
set(gca,'Color',[0.8 0.8 0.8]);