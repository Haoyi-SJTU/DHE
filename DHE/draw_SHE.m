% =========================================================================
% Function Name: draw_SHE
% Description: Visualize SHE (Symmetric Hyper-Ellipsoid) projection ellipses
%              for all robot joints in an animated sequence
% Purpose: Animate the evolution of disturbance resistance ellipsoids
%          across all joint subspaces over time for SHE representation
% 
% This function creates an animation showing the projection ellipses of the
% SHE for 12 joint subspaces. Each ellipse represents the disturbance
% resistance characteristics in a 2D joint space span{αi, βi}. Unlike EHE,
% SHE uses implicit quadratic form representation. The ellipses are plotted
% in a stacked arrangement and animated over time to show how disturbance
% characteristics evolve with robot configuration.
%
% Input Parameters:
%   coeff_SHE_series - 3D array of SHE coefficient matrices [data_length × 5 × 12]
%                      Each page (:,:,j) contains coefficients for ellipse j
%                      Each row i contains 5 coefficients for time i:
%                      coeff = [A, B, C, D, E] where:
%                      A*x² + B*y² + C*x*y + D*x + E*y = 1
%   data_length      - The length of the data
% 
% Output Parameters:
%   None (function creates and updates a figure with animation)
%
% SHE Ellipse Representation:
%   The implicit quadratic equation for each ellipse:
%   A*x² + B*y² + C*x*y + D*x + E*y = 1
%   
%   Where coefficients are stored as:
%   coeff(1) = A (x² coefficient)
%   coeff(2) = B (y² coefficient)
%   coeff(3) = C (x*y cross term coefficient)
%   coeff(4) = D (x linear coefficient)
%   coeff(5) = E (y linear coefficient)
%
% Visualization Details:
%   - Creates a single figure with 12 overlaid ellipses
%   - Each ellipse corresponds to a joint subspace span{αi, βi}
%   - Ellipses are filled with distinct colors from 'color_list.mat'
%   - Animation shows time evolution with 0.1s pause between frames
%   - Legend identifies each joint subspace
%   - Fixed axis limits [-1.2, 1.2] for consistent scaling
%   - Equal axis scaling ensures proper ellipse aspect ratio
%   - Grid overlay for reference
%
% Algorithm Flow:
%   1. For each time step i (1 to data_length):
%      a. Clear current axes
%      b. For each ellipse j (12 to 1, back to front):
%         - Extract 5 coefficients for current time and subspace
%         - Create implicit function f(x,y) = 0
%         - Use fimplicit to generate contour points
%         - Extract and store (x,y) data
%         - Delete the implicit plot object
%         - Fill the ellipse with corresponding color
%      c. Add legend and formatting
%      d. Update display and pause
%
% See Also:
%   draw_EHE
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================

function draw_SHE(coeff_SHE_series, data_length)

load('sample_data/color_list.mat', 'color12');

num_ellipses = size(coeff_SHE_series, 3); % 每张图的曲线数 (12)

for i = 1:data_length
    cla;
    hold on;
    grid on;
    axis equal;
    xlim([-1.2 1.2]);
    ylim([-1.2 1.2]);
    title(sprintf("SHE series: %d", i));


    for j = num_ellipses:-1:1
        coeff = squeeze(coeff_SHE_series(i, :, j));
        current_color = color12(j, :);

        f = @(x,y) coeff(1)*x.^2 + coeff(2)*y.^2 + coeff(3)*x.*y + ...
            coeff(4)*x + coeff(5)*y - 1;

        h = fimplicit(f, [-1.2 1.2 -1.2 1.2], 'Visible', 'off');

        x_data = h.XData;
        y_data = h.YData;

        delete(h);

        fill(x_data, y_data, current_color, ...
            'EdgeColor', current_color, ...
            'LineWidth', 1.5); 
    end

    lgd = legend('span\{\alpha1,\beta1\}', 'span\{\alpha2,\beta2\}', 'span\{\alpha3,\beta3\}', ...
        'span\{\alpha4,\beta4\}', 'span\{\alpha5,\beta5\}', 'span\{\alpha6,\beta6\}', ...
        'span\{\alpha7,\beta7\}', 'span\{\alpha8,\beta8\}', 'span\{\alpha9,\beta9\}', ...
        'span\{\alpha10,\beta10\}', 'span\{\alpha11,\beta11\}', 'span\{\alpha12,\beta12\}','FontName','Times New Roman');
    lgd.Location = "eastoutside";
    lgd.ItemTokenSize = [10, 18];
    lgd.Box = 'off';

    drawnow;
    pause(0.001);
end

hold off;

end