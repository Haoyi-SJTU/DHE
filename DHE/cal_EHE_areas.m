% =========================================================================
% Function Name: cal_EHE_areas
% Description: Calculate time series of areas for all EHE projection ellipses
% Purpose: Compute the geometric area of disturbance ellipsoid projections
%          in different planes to evaluate disturbance resistance
% Reference: Disturbance Hyper-ellipsoid: A Metric for Evaluating Disturbance 
%            Resistance of Hyper-redundant Robots
% 
% This function computes the areas of ellipsoid projections onto 12 different
% 2D planes. The projections are defined by the EHE kernel matrix, which 
% characterizes the robot's disturbance resistance characteristics in joint space.
%
% Input Parameters:
%   kernal_series - 3D array of EHE kernel matrices [n×n×data_length]
%                   Each slice (:,:,i) is the parameter matrix at time i
%                   Matrix is assumed to be symmetric positive definite
%                   
%   data_length   - Number of time samples (integer, positive)
% 
% Output Parameters:
%   area_series   - Matrix of ellipse areas [data_length × 12]
%                   Each row corresponds to a time sample
%                   Each column corresponds to a projection plane
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function area_series = cal_EHE_areas(kernal_series, data_length)

area_series = zeros(data_length,12);

for i = 1:data_length
    for j = 1: 12
        A = kernal_series(2*j-1,2*j-1);
        B = 2 * kernal_series(2*j-1,2*j);
        C = kernal_series(2*j,2*j);
        det_M = A * C - (B/2)^2;
        if det_M > 0
            area_series(i,j) = pi / sqrt(det_M);
        else
            error('This is not an ellipse equation (4AC - B² > 0).');
        end
    end
end

end

