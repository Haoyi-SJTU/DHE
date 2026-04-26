% Read Joint Angle File. 
% The joint angle file is a TXT file; 
% each line contains 24 joint angle data points, corresponding sequentially
% to α1, β1 through α24, β24. These joint angles are separated by tabs. 
% During simulation or operation on the physical robot, the robot begins 
% execution from the first line of the TXT file, moving according to the 
% joint angles specified in the file until it reaches the final line.
% input: 
%     q_file_path: the path to the joint angle data file.
% output:
%     q_data: the joint angle data
%     q_data_length: the joint angle data length

function [q_data, q_data_length, dof] = read_q_file(q_file_path)
fileID = fopen(q_file_path, 'r');
i=1;
while ~feof(fileID)
    line = fgetl(fileID);
    numbers = strsplit(line, '\t');
    for j = 1:length(numbers)
        q_data(i, j) = [str2double(numbers{j})];
    end
    i=i+1;
end
fclose(fileID);
q_data(:,1) = [];
[q_data_length, dof] = size(q_data);
end