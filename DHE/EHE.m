
function EHE(q_file_path)

load('sample_data/hrr_config.mat');

[q_data, data_length, dof] = read_q_file(q_file_path);

T_i = zeros(4,4,dof);
T_e_series = zeros(4, 4, data_length);
J_i_series = zeros(6, dof, data_length);
kernal = zeros(dof,dof);
kernal_series = zeros(dof,dof, data_length);

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

    kernal = J_i' * J_i;

    kernal_series(:,:,i) = kernal;

end

area_series = cal_EHE_areas(kernal_series, data_length)';


draw_EHE(kernal_series,data_length);
% kernal_process(kernal_series,q_data_length);

matrixplot(area_series(:,1:data_length), ...
    'FigSize','full','DisplayOpt','Off','TextColor',[0.6,0.6,0.6],'ColorBar','on','Grid','off');


end
















