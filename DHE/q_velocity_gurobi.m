% =========================================================================
% Compute angular velocity sequence for entire joint angle 
%              trajectory using Gurobi optimization
% Algorithm: Iteratively applies single_q_velocity_gurobi to compute smooth
%           angular velocities across all time steps for each degree of freedom
% Use Case: Robot motion planning, trajectory smoothing, velocity estimation
%           from discretely sampled joint angle data
%
% Input Parameters:
%   q_data      - Joint angle time series (radians) [data_length × dof]
%   delta_t     - Sampling time interval (seconds), scalar > 0
%   data_length - Number of time samples in the trajectory, integer > 1
%   dof         - Degrees of freedom (number of joints), integer > 0
%
% Output Parameters:
%   q_velocity  - Joint angular velocity time series (rad/s) 
%                 [data_length × dof]
%
% Algorithm Details:
%   1. Initializes output matrix with zeros
%   2. For each joint (DOF), iterates through time steps
%   3. At each time step, calls single_q_velocity_gurobi to compute optimal
%      angular velocity based on current and previous joint angles
%   4. Uses computed velocity as previous velocity for next time step
%   5. Processes all 24 joints (hardcoded loop limit - verify consistency)
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
% Example:
%   % Generate sample joint angle data
%   data_length = 100;
%   dof = 24;
%   delta_t = 0.01; % 10ms sampling
%   q_data = rand(data_length, dof); % Random joint angles
%   
%   % Compute angular velocities
%   q_vel = q_velocity_gurobi(q_data, delta_t, data_length, dof);
%
%   % Plot first joint's velocity profile
%   figure;
%   plot((0:data_length-1)*delta_t, q_vel(:,1));
%   xlabel('Time (s)');
%   ylabel('Angular Velocity (rad/s)');
%   title('Joint 1 Angular Velocity');
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
        q_vel_previous = q_velocity(j,i);
    end
end


end


