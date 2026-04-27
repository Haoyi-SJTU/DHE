
function SHE(q_file_path)

forward_kinematics_alpha = @(alpha, beta, L, h1, h2) ...
    [cos(alpha), 0, sin(alpha), 0;
     sin(alpha), 0, -cos(alpha), 0;
     0, 1, 0, 0;
     0, 0, 0, 1];

forward_kinematics_beta = @(alpha, beta, L, h1, h2) ...
    [cos(beta), 0, -sin(beta), (L+h1+h2)*cos(beta);
     sin(beta), 0, cos(beta), (L+h1+h2)*sin(beta);
     0, -1, 0, 0;
     0, 0, 0, 1];


load('sample_data/hrr_config.mat');

[q_data, data_length, dof] = read_q_file(q_file_path);% 读取关节角文件


t_data = zeros(6, data_length);
coeff_SHE_series = zeros(data_length,5,12);
T_i = zeros(4,4,25);%T^0_i
T_e_series = zeros(4, 4, data_length);
J_i_series = zeros(6, dof, data_length);
H_i_series = zeros(dof, dof, 6, data_length);
JTJ_series = zeros(dof,dof,data_length);





for i = 1:data_length
    T = eye(4,4);
    T_i(:,:,1) = T;
    for j = 1:2:23
        Ti = forward_kinematics_alpha(q_data(i,j), q_data(i,j+1), L, h1, h2);
        T = T * Ti;
        T_i(:,:,j) = T;
        Ti = forward_kinematics_beta(q_data(i,j), q_data(i,j+1), L, h1, h2);
        T = T * Ti;
        T_i(:,:,j+1) = T;
    end
    T_e_series(:,:,i) = T;

    for j = 1:24
        J_ij = Jacobian_rotate(T_i(:,:,j), T_e_series(:,:,i));
        J_i_series(:, j, i) = J_ij;
    end
    J_i = J_i_series(:, :, i);

    JiT = J_i';
    JTJ_series(:,:,i) = JiT*J_i;

    H_i = hessian_hrr(T_i, T_e_series(:,:,i), dof);

    H_i_series(:,:,:,i) = H_i;

end

q_velocity = q_velocity_gurobi(q_data, 1, data_length, dof);


for i = 1:data_length

    for q_dof = 1:2:23

        coeff_qHq = zeros(6,2);%
        coeff_Jq = zeros(6,2); 

        for H_dof = 1:6
            coeff_x2 = H_i_series(q_dof,q_dof,H_dof,i);
            coeff_y2 = H_i_series(q_dof+1,q_dof+1,H_dof,i);
            coeff_qHq(H_dof,:) = [coeff_x2 coeff_y2]; 
            coeff_Jq(H_dof,:) = [J_i_series(H_dof,q_dof,i), J_i_series(H_dof,q_dof+1,i)];
        end

        CORE_qdof = [coeff_qHq coeff_Jq];
        q_vel_x = q_velocity(i,q_dof);
        q_vel_y = q_velocity(i,q_dof+1);
        temp_coeff_IE = zeros(1,6);

        for H_dof = 1:6

            temp_coeff_IE(1) = temp_coeff_IE(1) + CORE_qdof(H_dof,3)^2;
            temp_coeff_IE(2) = temp_coeff_IE(2) + CORE_qdof(H_dof,4)^2;
            temp_coeff_IE(3) = temp_coeff_IE(3) + 2*CORE_qdof(H_dof,3)*CORE_qdof(H_dof,4);
            temp_coeff_IE(4) = temp_coeff_IE(4) + 2*CORE_qdof(H_dof,1) * CORE_qdof(H_dof,3) * q_vel_x^2 + ...
                2*CORE_qdof(H_dof,2)*CORE_qdof(H_dof,4) * q_vel_y^2;
            temp_coeff_IE(5) = temp_coeff_IE(5) + 2*CORE_qdof(H_dof,1) * CORE_qdof(H_dof,4) * q_vel_x^2 + ...
                2*CORE_qdof(H_dof,2)*CORE_qdof(H_dof,3) * q_vel_y^2;
            temp_coeff_IE(6) = temp_coeff_IE(6) + CORE_qdof(H_dof,1)^2*q_vel_x^4 + CORE_qdof(H_dof,2)^2*q_vel_y^4 + ...
                2*CORE_qdof(H_dof,1) * CORE_qdof(H_dof,2) * q_vel_x^2 * q_vel_y^2;

        end

        coeff_IE = [temp_coeff_IE(1)/(1-temp_coeff_IE(6))
            temp_coeff_IE(2)/(1-temp_coeff_IE(6))
            temp_coeff_IE(3)/(1-temp_coeff_IE(6))
            temp_coeff_IE(4)/(1-temp_coeff_IE(6))
            temp_coeff_IE(5)/(1-temp_coeff_IE(6))];

        coeff_SHE_series(i,:,(q_dof+1)/2) = coeff_IE;

    end

end


area_series = cal_SHE_areas(coeff_SHE_series, data_length)';


draw_SHE(coeff_SHE_series, data_length);


matrixplot(area_series(:,1:data_length), ...
    'FigSize','full','DisplayOpt','Off','TextColor',[0.6,0.6,0.6],'ColorBar','on','Grid','off');


end














