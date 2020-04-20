%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function updates the axis of the capsules
%
% Changliu Liu
% 2015.8.5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [pos,M]=CapPos_origin(base,DH,RoCap)
Msix2tool = [0.859250958834643,0.00134898513621668,-0.511552537308767,-0.107216311973238;
             0.0539084601303312,0.994157458745971,0.0935139342512386,-0.0343306766918563;
             0.508689913814001,-0.107928945573697,0.854158016145560,0.639182943012581;
             0,0,0,1];

nlink=size(DH,1);
pos=cell(1,nlink);
M=cell(1,nlink+1); M{1}=eye(4);
for i=1:nlink
    if i < nlink
        R=[cos(DH(i,1)) -sin(DH(i,1))*cos(DH(i,4)) sin(DH(i,1))*sin(DH(i,4));
            sin(DH(i,1)) cos(DH(i,1))*cos(DH(i,4)) -cos(DH(i,1))*sin(DH(i,4));
            0  sin(DH(i,4)) cos(DH(i,4))];
        T=[DH(i,3)*cos(DH(i,1));DH(i,3)*sin(DH(i,1));DH(i,2)];
        M{i+1}=M{i}*[R T; zeros(1,3) 1];
        for k=1:2
            pos{i}.p(:,k)=M{i+1}(1:3,1:3)*RoCap{i}.p(:,k)+M{i+1}(1:3,4)+base;
        end
        pos{i}.r = RoCap{i}.r;
    end
    if i == nlink % the end-effector tool has three capsule for GP50
        M{i+1}=M{i}*Msix2tool;
        for k=1:2
            pos{i}.p1(:,k)=M{i+1}(1:3,1:3)*RoCap{i}.p1(:,k)+M{i+1}(1:3,4)+base;
            pos{i}.p2(:,k)=M{i+1}(1:3,1:3)*RoCap{i}.p2(:,k)+M{i+1}(1:3,4)+base;
            pos{i}.p3(:,k)=M{i+1}(1:3,1:3)*RoCap{i}.p3(:,k)+M{i+1}(1:3,4)+base;
        end
        pos{i}.r1 = RoCap{i}.r1;
        pos{i}.r2 = RoCap{i}.r2;
        pos{i}.r3 = RoCap{i}.r3;
    end
end
end