function lags = calculate_lag(C14_results,d18O_results,lag_interp,max_samp,save_samp)

% loop through cores
for i = 1:length(C14_results.summary)
    C14_samples = C14_results.summary(i).age_samples;
    C14_depths = C14_results.summary(i).depth;
    d18O_depths = d18O_results.summary(i).depth;
    d18O_samples = d18O_results.summary(i).age_samples;

    % check for lag_times outside range of age models
    [lag_new C14_ind d18O_ind] = NaN_Check(C14_samples, d18O_samples, lag_interp);

    % only use max_samp samples for memory
    l = min([length(C14_ind) length(d18O_ind)]);
    if l > max_samp
        l = max_samp;
    end
    
    % loops through C14 samples
    depths = [];
    for j = 1:l
        % get depths of C14 samples corresponding to lag_interp times.
        % Only using samples that extend beyond range of interp time
        depths(:,j) = interp1(C14_samples(:,C14_ind(j)),C14_depths,lag_new);
    end
    
    % loops through C14 depths
    lag_core = [];
    for j = 1:l
        % finds ages of d18O samples at lag_interp depths
        d18O_ages = interp1(d18O_depths,d18O_samples(:,d18O_ind(1:l)),depths(:,j));
        lag_core(j).lag = d18O_ages - lag_new'; % reverse direction for IM vs EEP %lag_new' - d18O_ages
    end
    
    % stores results
    lags(i).name = C14_results.summary(i).name;
    lags(i).age = lag_new;
    if strcmp(save_samp,'yes')==1 % only save samples if indicated
        lags(i).samples = [lag_core(:).lag];
        lags(i).median = median(lags(i).samples,2);
        lags(i).lower_95 = quantile(lags(i).samples,0.025,2);
        lags(i).upper_95 = quantile(lags(i).samples,0.975,2);
    else
        samples = [lag_core(:).lag];
        lags(i).median = median(samples,2);
        lags(i).lower_95 = quantile(samples,0.025,2);
        lags(i).upper_95 = quantile(samples,0.975,2);
    end
end



        


    
    
    
    
    
    

