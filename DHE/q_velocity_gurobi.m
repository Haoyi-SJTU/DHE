% =========================================================================
% Compute angular velocity sequence for entire joint angle 
%              trajectory using Gurobi optimization
% Algorithm: Iteratively applies single_q_velocity_gurobi to compute smooth
%           angular velocities across all time steps for each joint
%
% Input Parameters:
%   q_data      - Joint angle time series (radians) [data_length × dof]
%   delta_t     - Sampling time interval (seconds)
%   data_length - Number of time samples in the trajectory
%   dof         - Degrees of freedom
%
% Output Parameters:
%   q_velocity  - Joint angular velocity time series (rad/s) 
%                 [data_length × dof]
%
% Processing Flow:
%   for i = 1:24
%       Initialize q_vel_previous = 0
%       for j = 2:data_length
%           q_velocity(j,i) = single_q_velocity_gurobi(
%                               q_data(j-1,i), q_data(j,i), 
%                               delta_t, q_vel_previous)
%           q_vel_previous = q_velocity(j,i)
%       end
%   end
%
% See Also:
%   single_q_velocity_gurobi
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================


function q_velocity = q_velocity_gurobi(q_data, delta_t, data_length, dof)

q_velocity = zeros(data_length, dof);
q_vel_previous = 0;

for i = 1:24
    for j = 2:data_length
        q_velocity(j,i) = single_q_velocity_gurobi(q_data(j-1, i), q_data(j, i), delta_t, q_vel_previous);
        % q_velocity(j,i) = single_q_velocity_new(q_data(j-1, i), q_data(j, i), delta_t, q_vel_previous);
        q_vel_previous = q_velocity(j,i);
    end
end


end


