% Calculating the HRR's Hessian Matrix
% This function is used to calculate the Hessian matrix for the 24-DOF HRR.
% We sequentially designate the robot's joints as α1, β1, and so on. And
% the homogeneous transformation matrix is designated as T_i(:,:,1), T_i(:,:,2), and so on.
% For details, please refer to the paper Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance Resistance of Hyper-redundant Robots
%
% input: 
%     T_i: the homogeneous transformation matrices for all joints
%     T_e: the homogeneous transformation matrices for the robot end
% output:
%     H_i: the HRR's Hessian Matrix

function H_i = hessian_hrr(T_i, T_e, dof)
H_i = zeros(dof, dof, 6);
for m = 1:dof
    for n = 1:dof
        if m >=2 && n >=2
            if m <= n
                H_i(m,n,1:3) = hessian_trans_up(T_i(:,:,m), T_i(:,:,n), T_e);%平移分量 sm*[sn*(P-Rn)]
                H_i(m,n,4:6) = hessian_rotate_up(T_i(:,:,m), T_i(:,:,n));%旋转分量 sm*sn
            else
                H_i(m,n,1:3) = hessian_trans_down(T_i(:,:,m), T_i(:,:,n), T_e);
                H_i(m,n,4:6) = hessian_rotate_down();
            end
        else
            H_i(m,n,1:3) = sym([0;0;0]);
            H_i(m,n,4:6) = sym([0;0;0]);
        end
    end
end
end