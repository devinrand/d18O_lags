function lags = calculate_lag_gebbie(d18O_results,lag_interp)

for i = 1:length(d18O_results.summary)% loop through core
    d18O_depth = d18O_results.summary(i).depth;
    d18O_samples = d18O_results.summary(i).age_samples;  
    
    lags(i).name = d18O_results.summary(i).name;
    lags(i).age = lag_interp;
    
    % depths corresponding to lag_interp times (i.e., synthetic depths/10) 
    lag_depths = lag_interp/10;   
    d18O_ages = interp1(d18O_depth,d18O_samples,lag_depths);
    lags(i).samples = d18O_ages - lag_interp';

    % calculate medians and quantiles
    lags(i).median = median(lags(i).samples,2);
    lags(i).lower_95 = quantile(lags(i).samples,0.025,2);
    lags(i).upper_95 = quantile(lags(i).samples,0.975,2);
end


