

if(~make_plots_journal)
    
    figure(1),subplot(2,1,1), plot(t_frame(3:end),cam_Vz_frame(3:end))
    xlim([t_frame(1),t_frame(end)])
    hold on, plot(t_frame(start_i:end_i),velocity_tot_forward_plot(start_i:end_i),'r');
    
    hold on, plot(t_frame(start_i:end_i),velocity_tot_forward_FB_plot(start_i:end_i),'g');
    hold on, plot(t_frame(start_i:end_i),velocity_tot_forward_LK_plot(start_i:end_i),'k');
    
    hold off
    ylim([-1 1])
    xlim([t_frame(1),t_frame(end)])
    ylabel('velocity')
    xlabel('Time[s]')
    title(['Forward Velocity of dataset ',num2str(track)])
    
    subplot(2,1,2), plot(t_frame(start_i:end_i),cam_Vx_frame(start_i:end_i))
    
    hold on, plot(t_frame(start_i:end_i),velocity_tot_sideways_plot(start_i:end_i),'r');
    
    hold on, plot(t_frame(start_i:end_i),velocity_tot_sideways_FB_plot(start_i:end_i),'g');
    hold on, plot(t_frame(start_i:end_i),velocity_tot_sideways_LK_plot(start_i:end_i),'k');
    
    hold off
    
    ylim([-1 1])
    xlim([t_frame(1),t_frame(end)])
    legend('Ground Truth', 'Edge Flow', 'F\"arneback','Lucas Kanade')
    
    ylabel('velocity')
    xlabel('Time[s]')
    title(['Sideways Velocity of dataset ',num2str(track)])
else
    
    
    time = t_frame(start_i:end_i);
    
    
    figure,subplot(2,1,1),
    
    plot(  time, velocity_x_optitrack),
    hold on
    
    plot(  time, velocity_x_edgeflow),
    plot(  time, velocity_x_farneback,'g') ,
    plot(  time, velocity_x_lucaskanade,'m:');
%     plot(time,velocity_x_edgeflow_global,'r--');
    plot(  time, velocity_x_edgeflow, 'r'),

    plot(time,zeros(size(time)),'k:'),
    hold off
    
    xlim([time(1),time(end)])
    
    xlim_figure =get(gca,'xlim');
    if track==4
        hleg= legend({'Groundtruth','Edge-FS',...
            'FarneBack', 'Lucas Kanade'},'orientation','horizontal' ,'Location','southwest');
        set(hleg,'FontSize',5);
        legend boxoff
    end
    
    ylim([-1.0 1.0])
    box off
    descr = {['\fontsize{6}NMXM_x:\color{red} ',num2str(nmxm_x,'%.4f'),' \color{green}(',num2str(nmxm_x_FB,'%.4f'),'),  \fontsize{6}\color{black}MSE_x\color{red}: ' ,num2str(MSE_x,'%.4f'),' \color{green}(',num2str(MSE_x_FB,'%.4f'),'), \fontsize{6}\color{black}var_x: \color{red}',num2str(var_x,'%.4f'),' (\color{green}',num2str(var_x_FB,'%.4f'),')']};
    text(xlim_figure(1),1,descr,...
        'VerticalAlignment','top',...
        'HorizontalAlignment','left', 'FontSize',4, 'BackgroundColor', 'w')
    xlabel('Time [s]');
    if track == 4
        
        
        ylabel('Velocity (x) [m/s]')
    end
    % title({' ';' '; 'velocity x-direction'})
    %y-direction
    subplot(2,1,2),
    plot(time, -velocity_y_optitrack),hold on,
    plot(  time, -velocity_y_edgeflow),
    plot(  time, -velocity_y_farneback,'g')
    s=plot(  time, -velocity_y_lucaskanade,'m:');
%         plost(time, -velocity_y_edgeflow_global,'r--');
    plot(  time, -velocity_y_edgeflow, 'r'),


    plot(time,zeros(size(time)),'k-')
    hold off
    
    %     legend('Groundtruth','EdgeFlow pixelwise','Edgeflow global')
    xlim([time(1),time(end)])
    ylim([-1.0 1.0])
    xlim_figure =get(gca,'xlim');
    
    descr = {['\fontsize{6}NMXM_y:\color{red} ',num2str(nmxm_y,'%.4f'),' \color{green}(',num2str(nmxm_y_FB,'%.4f'),'),  \fontsize{6}\color{black}MSE_y\color{red}: ' ,num2str(MSE_y,'%.4f'),' \color{green}(',num2str(MSE_y_FB,'%.4f'),'), \fontsize{6}\color{black}var_y: \color{red}',num2str(var_y,'%.4f'),' (\color{green}',num2str(var_y_FB,'%.4f'),')']};
    text(xlim_figure(1),1.0,descr,...
        'VerticalAlignment','top',...
        'HorizontalAlignment','left', 'FontSize',4,  'BackgroundColor', 'w')
    box off
    %     title('velocity y-direction')
    xlabel('Time [s]')
    if track == 4
        ylabel('Velocity (y) [m/s]')
    end
    set(gcf,'Position',[0 0 400 500])
    
    
    filename_savevel = sprintf('generated_plots/Edgeflow_Farneback_board_%d_data_%d',stereoboard_type,track);
    
    %     cleanfigure;
    matlab2tikz([filename_savevel,'.tex'],'height', '\figureheight', 'width', '\figurewidth',...
        'extraaxisoptions',['title style={font={\small\bfseries}},'...
        'legend style={font=\tiny},'])
    %printpdf(gcf,[filename_savevel,'.pdf'])
    
    filename = sprintf('generated_plots/Edgeflow_Farneback_board_%d_data_%d.png',stereoboard_type,track);
    
    
    saveas(gcf,filename)
    
    
    
end