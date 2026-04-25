% Calculating the Transformation Matrix T for Joint α
% We sequentially designate the robot's joints as α1, β1, and so on. 
% This function is used to calculate the homogeneous transformation matrix for the i-th α-joint.
% For details, please refer to the paper Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance Resistance of Hyper-redundant Robots
% 
% input:
%     alpha: the i-th alpha angle
%     beta: not used
%     L: the length of a robot link
%     h1: the lower length of a universal joint, it is half the length of a universal joint.
%     h1: the upper length of a universal joint, it is half the length of a universal joint.
% output:
%     T_i: the homogeneous transformation matrix for the i-th α-joint

function T_i = forward_kinematics_alpha(alpha, beta, L, h1, h2)
T_i = [cos(alpha), 0, sin(alpha), 0;
    sin(alpha), 0, -cos(alpha), 0;
    0, 1, 0, 0;
    0, 0, 0, 1];
end