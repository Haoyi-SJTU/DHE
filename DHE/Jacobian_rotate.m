% Calculating the i-th Jacobian Matrix of a Revolute Joint
%
% input: 
%     T_0_i: homogeneous transformation matrix from the base 
%             coordinate system to coordinate system *i*.
%     T_0_e: homogeneous transformation matrix from the base 
%             coordinate system to coordinate system *e*.
% output:
%     J_i: the i-th Jacobian Matrix of a revolute joint

function J_i = Jacobian_rotate(T_0_i, T_0_e)
z_i1 = T_0_i(1:3,3);
p_e = T_0_e(1:3,4);
p_i = T_0_i(1:3,4);
J_i = [cross(z_i1, p_e-p_i); z_i1];
end