% =========================================================================
% Function Name: forward_kinematics_beta
% Description: Calculate homogeneous transformation matrix for the i-th β-joint
%              in a hyper-redundant robot with universal joints
% Mathematical Basis: Forward kinematics for universal joint mechanism
%                     including both rotation and translation
% Reference: Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance 
%            Resistance of Hyper-redundant Robots
% 
% This function computes the transformation matrix for β-type joints in the
% robot's kinematic chain. The robot joints are sequentially designated as
% α1, β1, α2, β2, ... representing alternating universal joint rotations.
% β-joints include both rotation and translation components.
%
% Input Parameters:
%   alpha   - Rotation angle of the corresponding α-joint (radians) - NOT USED
%   beta    - Rotation angle of the i-th β-joint (radians)
%   L       - Length of a robot link (scalar, positive)
%   h1      - Lower length of a universal joint, half the length of a universal joint (scalar)
%   h2      - Upper length of a universal joint, half the length of a universal joint (scalar)
% 
% Output Parameters:
%   T_i     - Homogeneous transformation matrix for the i-th β-joint
%             [4×4 matrix] representing the transformation from α-joint to next α-joint
%
% Homogeneous Transformation Matrix:
%   T_i = [R_i, p_i; 0, 1] where:
%   R_i = [cos(β)   0  -sin(β)
%          sin(β)   0   cos(β)
%            0     -1     0  ]
%   p_i = [(L+h1+h2)*cos(β), (L+h1+h2)*sin(β), 0]'
%
% Matrix Structure:
%   T_i = [cos(β)   0  -sin(β)  (L+h1+h2)*cos(β)
%          sin(β)   0   cos(β)  (L+h1+h2)*sin(β)
%            0     -1     0           0
%            0      0     0           1]
%
% Physical Interpretation:
%   1. Rotation: β rotation about local axis (likely y-axis with -1 in R(3,2))
%   2. Translation: Movement along rotated x-axis by distance (L+h1+h2)
%   3. The translation magnitude (L+h1+h2) represents:
%      - L: length of the robot link
%      - h1: lower half-length of universal joint
%      - h2: upper half-length of universal joint
%
% See Also:
%   forward_kinematics_alpha, forward_kinematics
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================


function T_i = forward_kinematics_beta(alpha, beta, L, h1, h2)
T_i = [cos(beta), 0, -sin(beta), (L+h1+h2)*cos(beta);
    sin(beta), 0, cos(beta), (L+h1+h2)*sin(beta);
    0, -1, 0, 0;
    0, 0, 0, 1];
end