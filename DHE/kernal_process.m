% Calculate Matrix Norms and plot them
% 
% input:
%     kernal_series: The parameter matrix for the EHE ellipse. Please refer
%                   to the paper for the specific definition.
%     data_length: the length of the data
% output:
%     none
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