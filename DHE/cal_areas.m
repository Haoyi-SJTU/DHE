% Calculate time series of the areas of all ellipses
% 
% input:
%     kernal_series: The parameter matrix for the EHE ellipse. Please refer
%                   to the paper for the specific definition.
%     data_length: the length of the data
% output:
%     area_series: The sequence of areas of all EHE projection ellipses

function area_series = cal_areas(kernal_series, data_length)

area_series = zeros(data_length,12);

for i = 1:data_length
    for j = 1: 12
        a = sqrt(1 / kernal_series(2*j-1,2*j-1,i));
        b = sqrt(1 / kernal_series(2*j,2*j,i));
        area_series(i,j) = pi * a * b;
    end
end

end