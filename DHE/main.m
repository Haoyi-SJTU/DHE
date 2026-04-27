
% By running this code, you can generate the EHE and DHE ellipses 
% corresponding to a specific sequence of robot joint angles. 
% 
% Hardware and Software Requirements:
% - RAM > 8GB
% - MATLAB Version >= R2023a
% - MATLAB Robotics Toolbox installed
% - Gurobi Optimizer installed


clc;clear all;close all;

q_file_path = 'sample_data/sample_jointdata.txt';

EHE(q_file_path);

pause(5);

clc;clear all;close all;

SHE(q_file_path);


