% Compute the upper triangular part of the Hessian matrix 
% corresponding to the prismatic components.
%
% input: 
%     T_m: the homogeneous transformation matrix of the m-th joint
%     T_n: the homogeneous transformation matrix of the n-th joint
%     T_e: the homogeneous transformation matrix of the last joint
% output:
%     vector: the upper triangular part of the Hessian matrix 
%            corresponding to the prismatic components.

function vector = hessian_trans_up(T_m, T_n, T_e)
z_m = T_m(1:3,3);
z_n = T_n(1:3,3);
p_e = T_e(1:3,4);
p_n = T_n(1:3,4);
vector = cross(z_m, cross(z_n, (p_e - p_n)));
end