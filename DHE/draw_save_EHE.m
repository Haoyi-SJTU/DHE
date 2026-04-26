% Plot the EHE ellipses corresponding to all of the robot's joints and save it as a video.
% The robot's 24 joints form 12 sets of joint spaces—for example, 
% span{α1, β1}, span{α2, β2}, and so on. We have plotted the projection 
% ellipses for EHE, totaling 12 in number. These ellipses are displayed in 
% a stacked arrangement within the figure to conserve space.
% 
% input:
%     kernal_series: The parameter matrix for the EHE ellipse. Please refer
%                   to the paper for the specific definition.
%     data_length: the length of the data
% output:
%     none

function draw_save_EHE(kernal_series,data_length)

load('sample_data/color_list.mat');

writerObj = VideoWriter('myvideo.avi');
open(writerObj);

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
    frame = getframe(gcf);
    writeVideo(writerObj, frame);
    pause(0.001);
end

frame = getframe(gcf);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
writeVideo(writerObj, frame);
close(writerObj);
pause();


end