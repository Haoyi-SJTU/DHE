% =========================================================================
% Function Name: draw_EHE
% Description: Visualize EHE projection ellipses for all robot joints in an animated sequence
% Purpose: Animate the evolution of disturbance resistance ellipsoids across all joint subspaces over time
% 
% This function creates an animation showing the projection ellipses of the
% EHE for 12 joint subspaces. Each ellipse represents the disturbance
% resistance characteristics in a 2D joint space span{αi, βi}. The ellipses
% are plotted in a stacked arrangement and animated over time to show
% how disturbance characteristics evolve with robot configuration.
%
% Input Parameters:
%   kernal_series - 3D array of EHE kernel matrices [n × n × data_length]
%   data_length   - the length of the data
% 
% Output Parameters:
%   None (function creates and updates a figure with animation)
%
% Visualization Details:
%   - Creates a single figure with 12 overlaid ellipses
%   - Each ellipse corresponds to a joint subspace span{αi, βi}
%   - Ellipses are filled with distinct colors from 'color_list.mat'
%   - Animation shows time evolution with 1ms pause between frames
%   - Legend identifies each joint subspace
%   - Equal axis scaling ensures proper ellipse aspect ratio
%   - Grid overlay for reference
%
% Mathematical Formulation:
%   For each joint subspace j (j = 1 to 12):
%   x(θ) = cos(θ) / sqrt(K(2j-1, 2j-1))
%   y(θ) = sin(θ) / sqrt(K(2j, 2j))
%   where θ ∈ [0, 2π] and K is the kernel matrix
%
% See Also:
%   draw_SHE, darw_save_EHE
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function draw_EHE(kernal_series,data_length)

load('sample_data/color_list.mat');

figure;

theta=0:0.05:2*pi;

for i = 1:data_length
    h_fill = gobjects(1, 12);
    for j = 12:-1:1
        x=cos(theta) / sqrt(kernal_series(2*j-1,2*j-1));
        y=sin(theta) / sqrt(kernal_series(2*j,2*j));
        h_fill(j) = fill(x,y,color12(j,:),'EdgeColor','none');
        hold on;
    end
    grid on;
    axis equal;
    lgd = legend(h_fill, 'span\{\alpha1,\beta1\}', 'span\{\alpha2,\beta2\}', 'span\{\alpha3,\beta3\}', ...
        'span\{\alpha4,\beta4\}', 'span\{\alpha5,\beta5\}', 'span\{\alpha6,\beta6\}', ...
        'span\{\alpha7,\beta7\}', 'span\{\alpha8,\beta8\}', 'span\{\alpha9,\beta9\}', ...
        'span\{\alpha10,\beta10\}', 'span\{\alpha11,\beta11\}', 'span\{\alpha12,\beta12\}','FontName','Times New Roman');
    lgd.Location = "eastoutside";
    lgd.ItemTokenSize = [10, 18];
    lgd.Box = 'off';
    title(sprintf("EHE series: %d", i));
    hold off;
    pause(0.001);
end

end