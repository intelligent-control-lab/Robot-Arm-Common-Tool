% ## How to Add A New Robot Model

% Suppose we want to add a new robot called `myBot`, we need to:
% 1. Add a new case `myBot` in ```robotproperty.m``` (need to specify number of links, D-H parameters, and base)
% 2. Add `.mat` mesh model(s) of `myBot` in the folder ```figure```

% * If the mesh model is generated from a CAD model, name it `myBot.mat`. *To generate `.mat` mesh model from `.stl` file, 1) get `stlread` from [link](https://www.mathworks.com/matlabcentral/fileexchange/22409-stl-file-reader), 2) modify and run `RobotCADFromSTL`. 
% * If the mesh model is generated from a capsule model, name it `myBotCapsules.mat`.
% 65  RobotCADFromSTL.m 

% This file provides an example on how to get .mat robot model from .stl
% file. 'filename' should be changed to the path to your stl files.
%
% Function 'stlread' is available at
%   https://www.mathworks.com/matlabcentral/fileexchange/22409-stl-file-reader

clear
base={};link={};
prefix=pwd;
% The base
filename=[prefix,'/gp50stl/base_link.STL'];
[f, v, n]=stlread(filename);
base{1}.v = v;
base{1}.f = f;
base{1}.n = n;
c = zeros(size(n)); % c is all zero 
base{1}.c = c;
base{1}.color = 'k';
for j=1:size(v,1)
    base{1}.v(j,:) = base{1}.v(j,:) + [0,0,-0.259];
end

i = 1;
filename=[prefix,'/gp50stl/link1.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,0.053];
end
% from frame1 -> frame2
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[1,3,2]);
    link{i}.v(j,2) = -link{i}.v(j,2);
    link{i}.v(j,:) = link{i}.v(j,:) + [-0.145, 0.281, 0];
end


i = 2;
filename=[prefix,'/gp50stl/link2.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';

% design frame -> frame2
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[1,3,2]);
    link{i}.v(j,2) = -link{i}.v(j,2);
end
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,-0.1545];
end
% from frame2 -> frame3
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[2,1,3]);
    link{i}.v(j,1) = -link{i}.v(j,1);
    link{i}.v(j,:) = link{i}.v(j,:) + [-0.87, 0, 0];
end


i = 3;
filename=[prefix,'/gp50stl/link3.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';
% design frame -> frame3
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[3,1,2]);
end
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,-0.173];
end
% from frame3 -> frame4
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[1,3,2]);
    link{i}.v(j,2) = -link{i}.v(j,2);
    link{i}.v(j,:) = link{i}.v(j,:) + [-0.21, 0, 0];
end



i = 4;
filename=[prefix,'/gp50stl/link4.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';
% design frame -> frame4
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[3,2,1]);
    link{i}.v(j,2) = -link{i}.v(j,2);
end
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,0.32];
end
% from frame4 -> frame5
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[1,3,2]);
    link{i}.v(j,3) = -link{i}.v(j,3);
    link{i}.v(j,:) = link{i}.v(j,:) + [0, -1.025, 0];
end


i = 5;
filename=[prefix,'/gp50stl/link5.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';
% design frame -> frame5
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[3,1,2]);
end
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,-0.12];
end
% from frame5 -> frame6
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[1,3,2]);
    link{i}.v(j,2) = -link{i}.v(j,2);
    link{i}.v(j,:) = link{i}.v(j,:) + [0, 0, 0];
end


i = 6;
filename=[prefix,'/gp50stl/link6.STL'];
[f, v, n]=stlread(filename);
link{i}.v = v;
link{i}.f = f;
link{i}.n = n;
c = zeros(size(n)); % c is all zero 
link{i}.c = c;
link{i}.color = 'y';
% design frame -> frame6
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,[3,2,1]);
end
% origin offset
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0,0,0.175];
end
% from frame6 -> frame7
for j=1:size(v,1)
    link{i}.v(j,:) = link{i}.v(j,:) + [0, 0, -0.675];
end



save('figure/gp50.mat','base','link');