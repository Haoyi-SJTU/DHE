% =========================================================================
% Compute angular velocity of unit quaternion between consecutive time 
% steps using Gurobi solver.
% Mathematical Model: Quadratic programming (QP) approach, solving for optimal
%                    angular velocity by minimizing objective function of 
%                    angular velocity change under unit quaternion kinematics constraints
% Use Case: Unit quaternion attitude interpolation, motion smoothing, attitude estimation, etc.
%
% Input Parameters:
%   q_previous    - Unit quaternion at previous time step [4×1] or [1×4]
%   q_now         - Unit quaternion at current time step [4×1] or [1×4]
%   delta_t       - Time step (scalar), must be positive
%   q_vel_previous- Angular velocity at previous time step (scalar)
%
% Output Parameters:
%   vel           - Optimal angular velocity at current time step (scalar)
%
% Mathematical Model:
%   Objective: min 0.5*x'*Q*x + obj*x
%   Constraints: A*x = rhs
%   Decision variables x = [ω; a; b; c]
%   ω: current angular velocity (primary output)
%   a,b,c: auxiliary variables
%
% Constraints:
%   1. ω - a - c = 0
%   2. b*delta_t - c = 0
%
% Initial Value Setting:
%   x0 = [Δq/Δt; q_vel_previous; (Δq/Δt - q_vel_previous)/Δt; Δq/Δt - q_vel_previous]
%
% Example:
%   q_prev = [0.5, 0.5, 0.5, 0.5]';
%   q_now = [0.6, 0.4, 0.5, 0.5]';
%   dt = 0.1;
%   vel_prev = 0.5;
%   vel = single_q_velocity_gurobi(q_prev, q_now, dt, vel_prev);
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function vel = single_q_velocity_gurobi(q_previous, q_now, delta_t, q_vel_previous)

delta_q = q_now - q_previous;

names = {'x', 'y', 'z', 'w'};
model.varnames = names;
model.modelsense = 'min';

model.Q = sparse([0 0 0 0;
    0 8*delta_t^2+1 4*delta_t^3 0 ;
    0 4*delta_t^3 2*delta_t^4+8*delta_t^2 -8*delta_t;
    0 0 -8*delta_t 8;]);
model.obj = [0 -16*delta_t*delta_q-2*q_vel_previous -8*delta_q*delta_t^2 0];

model.A = sparse([1 -1 0 -1; 0 0 delta_t -1]);
model.rhs = [0 0];
model.sense = '=';

model.start = [delta_q/delta_t; q_vel_previous; (delta_q/delta_t-q_vel_previous)/delta_t; delta_q/delta_t-q_vel_previous];

% gurobi_write(model, 'qp.lp');
params.outputflag = 0;
results = gurobi(model, params);

% disp(results);
% 
% for v=1:length(names)
%     fprintf('%s %e\n', names{v}, results.x(v));
% end
vel = double(results.x(1));

end