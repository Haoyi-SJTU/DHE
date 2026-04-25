% Calculating the Transformation Matrix T for Joint β
% We sequentially designate the robot's joints as α1, β1, and so on. 
% This function is used to calculate the homogeneous transformation matrix for the i-th β-joint.
% For details, please refer to the paper Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance Resistance of Hyper-redundant Robots
% 
% input:
%     alpha: not used
%     beta: the i-th beta angle
%     L: the length of a robot link
%     h1: the lower length of a universal joint, it is half the length of a universal joint.
%     h1: the upper length of a universal joint, it is half the length of a universal joint.
% output:
%     T_i: the homogeneous transformation matrix for the i-th β-joint


function T_i = forward_kinematics_beta(alpha, beta, L, h1, h2)
T_i = [cos(beta), 0, -sin(beta), (L+h1+h2)*cos(beta);
    sin(beta), 0, cos(beta), (L+h1+h2)*sin(beta);
    0, -1, 0, 0;
    0, 0, 0, 1];
end