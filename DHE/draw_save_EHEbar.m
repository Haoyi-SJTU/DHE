% Display the EHE ellipse area series using a bar chart, update it based on 
% the joint movement sequence, and save the chart as a video.
% 
% input:
%     area_series: EHE ellipse area series
%     data_length: the length of the data
% output:
%     none
function draw_save_EHEbar(area_series, data_length)

load('sample_data/color_list.mat');


fig = figure(1);
writerObj = VideoWriter('EHE_ellipsoid_area_bar.avi');
open(writerObj);

for i = 1:data_length
    x = [1 2 3 4 5 6 7 8 9 10 11 12]';
    temp_area_series = area_series(:,i);

    for j = 1:12
        b = bar(j,temp_area_series(j),0.75,'stacked','edgecolor','none');  %0.75是柱形图的宽，可以更改
        xtips1 = b.XEndPoints;
        ytips1 = b.YEndPoints;
        labels1 = string(sprintf('%.2f', b.YData));
        text(xtips1,ytips1,labels1,'HorizontalAlignment','center', 'VerticalAlignment','bottom')
        set(b(1),'facecolor',color12(j,:));
        set(gca,'xticklabel',[]);
        hold on;
    end

    lgd = legend('span\{\alpha1,\beta1\}', 'span\{\alpha2,\beta2\}', 'span\{\alpha3,\beta3\}', ...
        'span\{\alpha4,\beta4\}', 'span\{\alpha5,\beta5\}', 'span\{\alpha6,\beta6\}', ...
        'span\{\alpha7,\beta7\}', 'span\{\alpha8,\beta8\}', 'span\{\alpha9,\beta9\}', ...
        'span\{\alpha10,\beta10\}', 'span\{\alpha11,\beta11\}', 'span\{\alpha12,\beta12\}','FontName','Times New Roman');
    lgd.Location = "eastoutside";
    lgd.ItemTokenSize = [10, 18];
    lgd.Box = 'off';
    title(sprintf("series: %d", i));
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
close(writerObj);

end