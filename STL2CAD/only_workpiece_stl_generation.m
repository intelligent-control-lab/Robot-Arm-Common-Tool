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
base={};link={};workpiece={};
prefix=pwd;

% The base
filename=[prefix,'/gp50stl/wp_recenter.STL'];
[f, v, n]=stlread(filename);
workpiece{1}.v = v;
workpiece{1}.f = f;
workpiece{1}.n = n;
c = zeros(size(n)); % c is all zero 
workpiece{1}.c = c;
workpiece{1}.color = 'k';
for j=1:size(v,1)
    workpiece{1}.v(j,:) = workpiece{1}.v(j,:) - [0,0.20563,0];
end

save('figure/workpiece.mat','workpiece');