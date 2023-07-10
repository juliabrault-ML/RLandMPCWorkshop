function f = buildFigure()
            
    f = figure(...
        'Toolbar','none',...
        'Visible','on',...
        'HandleVisibility','off', ...
        'NumberTitle','off',...
        'Name',getString(message('rl:env:VizNameCartPole')),... 
        'MenuBar','none');
    if ~strcmp(f.WindowStyle,'docked')
        f.Position(3:4) = [600 200];
    end
    ha = gca(f);
    
    ha.XLimMode = 'manual';
    ha.YLimMode = 'manual';
    ha.ZLimMode = 'manual';
    ha.DataAspectRatioMode = 'manual';
    ha.PlotBoxAspectRatioMode = 'manual';
    ha.YTick = [];
    
    ha.XLim = [-5 5];
    ha.YLim = [0 3];
    
    hold(ha,'on');
end