% =========================================================================
% Function Name: forward_kinematics_alpha
% Description: Calculate homogeneous transformation matrix for the i-th α-joint
%              in a hyper-redundant robot with universal joints
% Mathematical Basis: Forward kinematics for universal joint mechanism
% Reference: Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance 
%            Resistance of Hyper-redundant Robots
% 
% This function computes the transformation matrix for α-type joints in the
% robot's kinematic chain. The robot joints are sequentially designated as
% α1, β1, α2, β2, ... representing alternating universal joint rotations.
%
% Input Parameters:
%   alpha   - Rotation angle of the i-th α-joint (radians)
%   beta    - Rotation angle of the corresponding β-joint (radians) - NOT USED
%   L       - Length of a robot link (scalar, positive)
%   h1      - Lower length of a universal joint, half the length of a universal joint (scalar)
%   h2      - Upper length of a universal joint, half the length of a universal joint (scalar)
% 
% Output Parameters:
%   T_i     - Homogeneous transformation matrix for the i-th α-joint
%             [4×4 matrix] representing the transformation from joint i-1 to joint i
%
% Homogeneous Transformation Matrix:
%   T_i = [R_i, 0; 0, 1] where R_i is the rotation matrix:
%   R_i = [cos(alpha), 0, sin(alpha);
%          sin(alpha), 0, -cos(alpha);
%          0, 1, 0]
%
% Coordinate Frame Convention:
%   The transformation assumes a specific coordinate frame assignment for
%   universal joints. The α-rotation is typically about the local y-axis or
%   z-axis depending on the robot's DH parameter convention.
%
% Matrix Structure:
%   T_i = [cos(α)   0   sin(α)   0
%          sin(α)   0  -cos(α)   0
%            0      1     0      0
%            0      0     0      1]
%
% Note: The translation components (4th column) are all zeros, indicating
%       this matrix represents a pure rotation transformation. Actual link
%       translations are likely handled in β-joint transformations or
%       in subsequent composite transformations.
%
% Example:
%   % Calculate transformation for α-joint with 30-degree rotation
%   alpha = deg2rad(30);
%   beta = deg2rad(45);  % Not used in this function
%   L = 0.1;    % 10cm link length
%   h1 = 0.01;  % 1cm lower universal joint half-length
%   h2 = 0.01;  % 1cm upper universal joint half-length
%   
%   T_alpha = forward_kinematics_alpha(alpha, beta, L, h1, h2);
%   
%   % Extract rotation matrix
%   R = T_alpha(1:3, 1:3);
%   disp('Rotation matrix for α-joint:');
%   disp(R);
%
% Notes:
%   1. The 'beta' input parameter is not used in this function but is
%      included for interface consistency with β-joint functions
%   2. The parameters L, h1, h2 are not used in the current implementation
%      but are included for potential future extensions
%   3. This represents a pure rotation transformation (no translation)
%   4. The matrix is orthogonal with determinant 1 (proper rotation)
%   5. For complete forward kinematics, chain with β-joint transformations:
%      T_total = T_alpha1 * T_beta1 * T_alpha2 * T_beta2 * ...
%   6. The specific axis of rotation should be verified against the paper's
%      coordinate frame definitions
%
% See Also:
%   forward_kinematics_beta, forward_kinematics
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function T_i = forward_kinematics_alpha(alpha, beta, L, h1, h2)
T_i = [cos(alpha), 0, sin(alpha), 0;
    sin(alpha), 0, -cos(alpha), 0;
    0, 1, 0, 0;
    0, 0, 0, 1];
end