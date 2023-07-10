function updatePlot(Observations)
    
    persistent f

    if isempty(f) || ~isvalid(f)
        f = buildFigure();
    end

    env.Length = 0.5;
    env.ThetaThresholdRadians = 12 * pi/180;
    env.XThreshold = 2.4;
    env.State = Observations;
    
    ha = gca(f);
    
    % ch is the height of the cart
    ch = 0.4;
    % cw is the width of the cart
    cw = 0.4;
    % ph is the length of the pole
    ph = env.Length*2;
    % pw is the width of the pole
    pw = cw/2;
    % theta limits
    theta_lim = env.ThetaThresholdRadians;
    y_theta_lim_ = cos(theta_lim)*ph*1.5;
    x_theta_lim_ = sin(theta_lim)*ph*1.5;
    x_x_lim = env.XThreshold;
    y_x_lim = max(ha.YLim);
    
    % extract position and angle
    state = env.State;
    x = state(1);
    theta = -state(3);
    
    cartplot = findobj(ha,'Tag','cartplot');
    poleplot = findobj(ha,'Tag','poleplot');
    
    theta_lim_lt_plot = findobj(ha,'Tag','thetalimltplot');
    theta_lim_rt_plot = findobj(ha,'Tag','thetalimrtplot');
    
    x_lim_lt_plot = findobj(ha,'Tag','xlimltplot');
    x_lim_rt_plot = findobj(ha,'Tag','xlimrtplot');
    
    if isempty(cartplot) || ~isvalid(cartplot) ...
            || isempty(poleplot) || ~isvalid(poleplot) ...
            || isempty(theta_lim_lt_plot) || ~isvalid(theta_lim_lt_plot) ...
            || isempty(theta_lim_rt_plot) || ~isvalid(theta_lim_rt_plot) ...
            || isempty(x_lim_lt_plot)     || ~isvalid(x_lim_lt_plot)     ...
            || isempty(x_lim_rt_plot)     || ~isvalid(x_lim_rt_plot)
        delete(cartplot);
        delete(poleplot);
        delete(theta_lim_lt_plot);
        delete(theta_lim_rt_plot);
        delete(x_lim_lt_plot);
        delete(x_lim_rt_plot);
        
        % Create polyshape objects
        cartpoly = polyshape([-cw/2,-cw/2,cw/2,cw/2],[0   ,ch       ,ch     ,0   ]);
        polepoly = polyshape([-pw/2,-pw/2,pw/2,pw/2],[ch/2,ph + ch/2,ph+ch/2,ch/2]);
        
        % Create the theta limit lines
        lineargs = {...
            'LineStyle'     ,'--', ...
            'Color'         ,'k' , ...
            'LineWidth'     ,1     ...
            };
        theta_lim_lt_plot = line(ha,[0 0],[0 0],lineargs{:});
        theta_lim_rt_plot = line(ha,[0 0],[0 0],lineargs{:});
        
        % Create the x limit lines
        x_lim_lt_plot = line(ha,[0 0],[0 0],lineargs{:});
        x_lim_rt_plot = line(ha,[0 0],[0 0],lineargs{:});
        
        cartplot = plot(ha,cartpoly);
        cartplot.Tag = 'cartplot';
        poleplot = plot(ha,polepoly);
        poleplot.Tag = 'poleplot';
        
        theta_lim_lt_plot.Tag = 'thetalimltplot';
        theta_lim_rt_plot.Tag = 'thetalimrtplot';
        
        x_lim_lt_plot.Tag = 'xlimltplot';
        x_lim_rt_plot.Tag = 'xlimrtplot';
    else
        cartpoly = cartplot.Shape;
        polepoly = poleplot.Shape;
    end
    
    [cartposx,~       ] = centroid(cartpoly);
    [poleposx,poleposy] = centroid(polepoly);
    dx = x - cartposx;
    dtheta = theta - atan2(cartposx-poleposx,poleposy-ch/2);
    % wrap deflection
    dtheta = atan2(sin(dtheta),cos(dtheta));
    
    cartpoly = translate(cartpoly,[dx,0]);
    polepoly = translate(polepoly,[dx,0]);
    polepoly = rotate   (polepoly,rad2deg(dtheta),[x,ch/2]);
    
    cartplot.Shape = cartpoly;
    poleplot.Shape = polepoly;
    
    theta_lim_lt_plot.XData = [0 -x_theta_lim_] + x - pw/2;
    theta_lim_lt_plot.YData = [0  y_theta_lim_] + ch/2;
    
    theta_lim_rt_plot.XData = [0  x_theta_lim_] + x + pw/2;
    theta_lim_rt_plot.YData = [0  y_theta_lim_] + ch/2;
    
    x_lim_lt_plot.XData = [0 0] - x_x_lim;
    x_lim_lt_plot.YData = [0 y_x_lim];
    
    x_lim_rt_plot.XData = [0 0] + x_x_lim;
    x_lim_rt_plot.YData = [0 y_x_lim];
    
    % if constraints are violated, change the line to red
    c1 = 'r'; c2 = [0.0 0.5 0.0];
    if theta > theta_lim
        theta_lim_lt_plot.Color = c1;
        theta_lim_rt_plot.Color = c2;
        theta_lim_lt_plot.LineStyle = '-';
        theta_lim_rt_plot.LineStyle = '--';
    elseif theta < -theta_lim
        theta_lim_lt_plot.Color = c2;
        theta_lim_rt_plot.Color = c1;
        theta_lim_lt_plot.LineStyle = '--';
        theta_lim_rt_plot.LineStyle = '-';
    else
        theta_lim_lt_plot.Color = c2;
        theta_lim_rt_plot.Color = c2;
        theta_lim_lt_plot.LineStyle = '--';
        theta_lim_rt_plot.LineStyle = '--';
    end
    if x < -x_x_lim
        x_lim_lt_plot.Color = c1;
        x_lim_rt_plot.Color = c2;
        x_lim_lt_plot.LineStyle = '-';
        x_lim_rt_plot.LineStyle = '--';
    elseif x > x_x_lim
        x_lim_lt_plot.Color = c2;
        x_lim_rt_plot.Color = c1;
        x_lim_lt_plot.LineStyle = '--';
        x_lim_rt_plot.LineStyle = '-';
    else
        x_lim_lt_plot.Color = c2;
        x_lim_rt_plot.Color = c2;
        x_lim_lt_plot.LineStyle = '--';
        x_lim_rt_plot.LineStyle = '--';
    end
    
    % Refresh rendering in figure window
    drawnow();

end