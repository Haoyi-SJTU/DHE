% =========================================================================
% Function Name: forward_kinematics
% Description: Calculate homogeneous transformation matrix for the combined
%              α-joint and β-joint (universal joint pair) in a hyper-redundant robot
% Mathematical Basis: Composite forward kinematics for universal joint mechanism
%                     combining α and β rotations with link translation
% Reference: Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance 
%            Resistance of Hyper-redundant Robots
% 
% This function computes the transformation matrix for a complete universal
% joint module consisting of an α-joint followed by a β-joint. The robot
% joints are sequentially designated as α1, β1, α2, β2, ... representing
% alternating universal joint rotations.
%
% Input Parameters:
%   alpha   - Rotation angle of the i-th α-joint (radians)
%   beta    - Rotation angle of the i-th β-joint (radians)
%   L       - Length of a robot link (scalar, positive)
%   h1      - Lower length of a universal joint, half the length of a universal joint (scalar)
%   h2      - Upper length of a universal joint, half the length of a universal joint (scalar)
% 
% Output Parameters:
%   T_i     - Homogeneous transformation matrix for the combined α-β joint pair
%             [4×4 matrix] representing the transformation from joint i-1 to joint i
%
% Homogeneous Transformation Matrix:
%   
%   R_i = [cos(α)cos(β)  -sin(α)   cos(α)sin(β)
%          sin(α)cos(β)   cos(α)  -sin(α)sin(β)
%          sin(β)          0        cos(β)     ]
%   p_i = [(L+h1+h2)*cos(α)cos(β),
%          (L+h1+h2)*sin(α)cos(β),
%          (L+h1+h2)*sin(β)]'
%
% Matrix Structure:
%   T_i = [cos(α)cos(β)  -sin(α)   cos(α)sin(β)  (L+h1+h2)*cos(α)cos(β)
%          sin(α)cos(β)   cos(α)  -sin(α)sin(β)  (L+h1+h2)*sin(α)cos(β)
%          sin(β)          0        cos(β)       (L+h1+h2)*sin(β)
%            0              0          0                 1        ]
%
% Physical Interpretation:
%   1. Rotation: Sequential rotation of α then β (or composition of both)
%   2. Translation: Movement along the rotated axis by distance (L+h1+h2)
%   3. The translation magnitude (L+h1+h2) represents:
%      - L: length of the robot link
%      - h1: lower half-length of universal joint
%      - h2: upper half-length of universal joint
%
% Relationship to Individual Joint Functions:
%   This function combines the effects of forward_kinematics_alpha and
%   forward_kinematics_beta:
%   T_combined = T_alpha * T_beta
%   (Order depends on specific kinematic convention)
%
% Coordinate Frame Convention:
%   - The rotation matrix follows a specific Euler angle convention
%   - First column represents the new x-axis direction
%   - Third column represents the new z-axis direction
%   - Translation is along the rotated axis defined by (α, β)
%
% Example:
%   % Calculate transformation for α=30°, β=45°
%   alpha = deg2rad(30);
%   beta = deg2rad(45);
%   L = 0.1;    % 10cm link length
%   h1 = 0.01;  % 1cm lower universal joint half-length
%   h2 = 0.01;  % 1cm upper universal joint half-length
%   
%   T = forward_kinematics(alpha, beta, L, h1, h2);
%   
%   % Extract components
%   R = T(1:3, 1:3);
%   p = T(1:3, 4);
%   
%   fprintf('Rotation matrix:\n');
%   disp(R);
%   fprintf('Translation vector: [%.4f, %.4f, %.4f] m\n', p);
%   fprintf('Translation distance: %.4f m (expected: %.4f)\n', ...
%           norm(p), L+h1+h2);
%
% Notes:
%   1. This is a composite transformation representing one complete
%      universal joint module (α + β joints)
%   2. The translation distance should equal norm(p) = L+h1+h2
%   3. The rotation matrix is orthogonal with det(R) = 1
%   4. For complete robot kinematics, chain multiple T_i matrices:
%      T_total = T_1 * T_2 * ... * T_n
%   5. The specific Euler angle sequence (α then β) should be verified
%      against the paper's coordinate frame definitions
%   6. This function is equivalent to multiplying individual α and β
%      transformation matrices (order matters!)
%
% Verification:
%   % Check orthogonality
%   R = T_i(1:3, 1:3);
%   isOrthogonal = all(abs(R'*R - eye(3)) < 1e-10, 'all');
%   
%   % Check translation magnitude
%   p = T_i(1:3, 4);
%   transMag = norm(p);
%   expectedMag = L + h1 + h2;
%
% See Also:
%   forward_kinematics_alpha, forward_kinematics_beta, compose_transforms
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function T_i = forward_kinematics(alpha, beta, L, h1, h2)
T_i = [cos(alpha)*cos(beta), -sin(alpha), cos(alpha)*sin(beta), (L+h1+h2)*cos(alpha)*cos(beta);
    sin(alpha)*cos(beta), cos(alpha), -sin(alpha)*sin(beta), (L+h1+h2)*sin(alpha)*cos(beta);
    sin(beta), 0, cos(beta), (L+h1+h2)*sin(beta);
    0, 0, 0, 1];
end
