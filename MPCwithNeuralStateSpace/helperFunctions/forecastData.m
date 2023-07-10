function [Tatm_w_for_preview,tou_pricing_for_preview,TinIC,sinePhase,...
    sineAmplitude,sineBias,sineFreq,T_comfort_min,T_comfort_max] = forecastData(Ts)
    
    TinIC = 20; % in C

    T_comfort_min = 20; % in C
    T_comfort_max = 22; % in C
    
    t = (0:Ts:2*24*3600)';
    
    sinePhase = 0;
    sineAmplitude = 4;
    sineBias = 8;
    sineFreq = 2*pi/(48*3600);

    Tatm_w_for_preview.time = t(1:end-1);
    Tatm_w_for_preview.signals.values = sineAmplitude*sin(sineFreq*t(1:floor(end/2))+sinePhase) + sineBias;
    Tatm_w_for_preview.signals.values = [Tatm_w_for_preview.signals.values; Tatm_w_for_preview.signals.values];
    
    tou_pricing_data = zeros(floor(length(t)/2),1);
    for ii=1:floor(length(t)/2)
        if t(ii)/3600 < 10 || t(ii)/3600 >= 21 
            tou_pricing_data(ii) = 0.025; % Off-peak
        else
            tou_pricing_data(ii) = 0.14; % On-peak between 10AM to 9PM
        end
    end
    tou_pricing_for_preview.time = t(1:end-1);
    tou_pricing_for_preview.signals.values = [tou_pricing_data; tou_pricing_data];
    
    do_plot = false;
    if do_plot
        figure;
        plot(tou_pricing_for_preview.time(1:floor(end/2))/3600,tou_pricing_for_preview.signals.values(1:floor(end/2)));
        xticks((0:3:24)');
        xlim([0 24]);
        ylim([0 0.15]);
        xlabel('Time (Hours)');
        ylabel('$/kWh');
        title('Time of Use Electricity Pricing');
    end
    

end