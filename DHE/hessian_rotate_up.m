% Compute the upper triangular part of the Hessian matrix 
% corresponding to the rotational components.
%
% input: 
%     T_m: the homogeneous transformation matrix of the m-th joint
%     T_n: the homogeneous transformation matrix of the n-th joint
% output:
%     vector: the upper triangular part of the Hessian matrix 
%            corresponding to the rotational components.

function vector = hessian_rotate_up(T_m, T_n)
z_m = T_m(1:3,3);
z_n = T_n(1:3,3);
vector = cross(z_m, z_n);
end