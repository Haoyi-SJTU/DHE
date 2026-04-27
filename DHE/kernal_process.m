% =========================================================================
% Function Name: kernal_process
% Description: Calculate and visualize various matrix norms and condition
%              number for a series of kernel matrices over time
% 
% Input Parameters:
%   kernal_series - 3D array of kernel matrices [m×n×data_length]
%                   Each slice (:,:,i) contains the EHE ellipse parameter
%                   matrix at time step i
%   data_length   - Number of time samples (integer, positive)
% 
% Output Parameters:
%   None (function generates plots)
%
% Computed Metrics:
%   1. L1 Norm (Maximum absolute column sum)
%       norm_1(A) = max(sum(abs(A), 1))
%   2. L2 Norm (Spectral norm, largest singular value)
%       norm_2(A) = σ_max(A)
%   3. L-Infinity Norm (Maximum absolute row sum)
%       norm_inf(A) = max(sum(abs(A), 2))
%   4. Frobenius Norm (Euclidean norm for matrices)
%       norm_fro(A) = sqrt(sum(diag(A'*A)))
%   5. Condition Number (based on L2 norm)
%       cond_2(A) = σ_max(A) / σ_min(A)
%
% Visualization Layout (5×2 grid):
%   Row 1: L1 Norm and its logarithm
%   Row 2: L2 Norm and its logarithm
%   Row 3: L-Infinity Norm and its logarithm
%   Row 4: Frobenius Norm and its logarithm
%   Row 5: Condition Number and its logarithm
%
% Example:
%   % Generate synthetic kernel series
%   data_length = 100;
%   m = 3; n = 3;
%   kernal_series = zeros(m, n, data_length);
%   for i = 1:data_length
%       kernal_series(:,:,i) = randn(m, n) + 5*eye(m, n);
%   end
%   
%   % Analyze matrix norms
%   kernal_process(kernal_series, data_length);
%   
%   % Alternatively, if kernal_series is exactly 100 slices
%   kernal_process(kernal_series, size(kernal_series, 3));
%
% Performance Considerations:
%   - Time complexity: O(data_length * min(m,n)^3) for SVD in cond()
%   - Memory usage: Stores 5 vectors of length data_length
%   - Suitable for offline analysis of moderate data lengths
%
% Author: Haoyi Song
% Date: 2026-04-27
% =========================================================================


function kernal_process(kernal_series,data_length)
figure;
norm_2 = zeros(data_length,1);
norm_1 = zeros(data_length,1);
norm_max = zeros(data_length,1);
norm_frobenius = zeros(data_length,1);
cond_2 = zeros(data_length,1);
for i = 1:data_length
    norm_1(i) = (norm(kernal_series(:,:,i),1));
    norm_2(i) = (norm(kernal_series(:,:,i)));
    norm_max(i) = norm(kernal_series(:,:,i),"inf");
    norm_frobenius(i) = (norm(kernal_series(:,:,i),"fro"));
    cond_2(i) = (cond(kernal_series(:,:,i)));
end

subplot(5,2,1);
plot(norm_1);
title('L1 Norm');
subplot(5,2,2);
plot(log10(norm_1));
title('lg(L1 Norm)');
subplot(5,2,3);
plot(norm_2);
title('L2 Norm');
subplot(5,2,4);
plot(log10(norm_2));
title('lg(L2 Norm)');
subplot(5,2,5);
plot(norm_max);
title('L-Infinity Norm');
subplot(5,2,6);
plot(log10(norm_max));
title('lg(L-Infinity Norm)');
subplot(5,2,7);
plot(norm_frobenius);
title('Frobenius Norm');
subplot(5,2,8);
plot(log10(norm_frobenius));
title('lg(Frobenius Norm)');
subplot(5,2,9);
plot(cond_2);
title('Condition Number');
subplot(5,2,10);
plot(log10(cond_2));
title('lg(Condition Number)');

end