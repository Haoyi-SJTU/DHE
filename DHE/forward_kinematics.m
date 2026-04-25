% Calculating the Transformation Matrix T for Joint α and Joint β
% We sequentially designate the robot's joints as α1, β1, and so on. 
% This function is used to calculate the homogeneous transformation matrix for the  α-joint and β-joint.
% For details, please refer to the paper Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance Resistance of Hyper-redundant Robots
% 
% input:
%     alpha: the i-th alpha angle
%     beta: the i-th beta angle
%     L: the length of a robot link
%     h1: the lower length of a universal joint, it is half the length of a universal joint.
%     h1: the upper length of a universal joint, it is half the length of a universal joint.
% output:
%     T_i: the homogeneous transformation matrix for the i-th α-joint and β-joint

function T_i = forward_kinematics(alpha, beta, L, h1, h2)
T_i = [cos(alpha)*cos(beta), -sin(alpha), cos(alpha)*sin(beta), (L+h1+h2)*cos(alpha)*cos(beta);
    sin(alpha)*cos(beta), cos(alpha), -sin(alpha)*sin(beta), (L+h1+h2)*sin(alpha)*cos(beta);
    sin(beta), 0, cos(beta), (L+h1+h2)*sin(beta);
    0, 0, 0, 1];
end
