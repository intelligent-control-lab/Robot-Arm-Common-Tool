% draw gp50
% clc
clear

addpath('Library')
ROBOT = 'GP50';
robot=robotproperty_detail(ROBOT);
DH = robot.DH;
jointn = 1; % move which joint
orig = DH(jointn,1);
% for theta = 0:0.02:pi/2
safe_theta = robot.DH(:,1);
safe_theta = safe_theta + [0;0;0;0;0;0];
RoBoundary = [];
for step = 1:size(safe_theta, 2)
    theta = safe_theta(:,step);
    DH(:,1) = theta;
    [pos,M]=CapPos_origin(robot.base,DH,robot.cap);
    color = [1,0.5,0.2];
    handle=[];
    points = 21;
    for i = 1:size(pos,2)
        posi = pos{i};
        r1 = posi.p(:,1);
        r2 = posi.p(:,2);
        R = posi.r;
        if r1 == r2 % sphere case
            [X,Y,Z] = sphere(points);
            X = X*R;
            Y = Y*R;
            Z = Z*R;
            data.X = X+robot.cap{i}.p(1,1);
            data.Y = Y+robot.cap{i}.p(2,1);
            data.Z = Z+robot.cap{i}.p(3,1);
            RoBoundary = [RoBoundary {data}];
            X = X + r1(1);
            Y = Y + r1(2);
            Z = Z + r1(3);
            
        else
            % capsule case 
            % generate cylinder 
            cap1 = robot.cap{i}.p(:,1);
            cap2 = robot.cap{i}.p(:,2);
            [X,Y,Z] = capsule_generate(R, cap1, cap2);
            data.X = X;
            data.Y = Y;
            data.Z = Z;
            RoBoundary = [RoBoundary {data}];
            % transform the point 
            for n1 = 1:size(X,1)
                for n2 = 1:size(X,2)
                    newvec=[X(n1,n2),Y(n1,n2),Z(n1,n2)]*M{i+1}(1:3,1:3)'+M{i+1}(1:3,4)'+robot.base';
                    X(n1,n2)=newvec(1);
                    Y(n1,n2)=newvec(2);
                    Z(n1,n2)=newvec(3);
                end
            end
            
        end
        surf(X,Y,Z);
        hold on
    end
    view([1,-0.5,0.4]);
    xlim=[-1,2];
    ylim=[-1,2];
    zlim=[0,2];
    axis([xlim,ylim,zlim]);
    lighting=camlight('left');
    set(gca,'Color',[0.8 0.8 0.8]);
    wall{1}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(1),ylim(2),ylim(2),ylim(1)],[zlim(1),zlim(1),zlim(1),zlim(1)],[0.5,0.5,0.5]);
    wall{2}.handle=fill3([xlim(1),xlim(1),xlim(1),xlim(1)],[ylim(1),ylim(1),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[0,0.9,0.9]);
    wall{3}.handle=fill3([xlim(1),xlim(1),xlim(2),xlim(2)],[ylim(2),ylim(2),ylim(2),ylim(2)],[zlim(1),zlim(2),zlim(2),zlim(1)],[0,0.9,0.9]);
    axis equal
end
save('figure/gp50Capsules.mat','RoBoundary');

