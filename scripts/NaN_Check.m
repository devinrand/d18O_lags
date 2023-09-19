function [new_times,C14_ind, d18O_ind] = NaN_Check(C14_samples,d18O_samples,lag_interp)

% new_times = core-specific times in which lags will be calculated
% that are in range of age models

% C14_ind and d18O_ind specify locations of age model samples that extend
% beyond range of new_times

% If more than crit % of age model samples do not extend beyond a
% lag_interp time, than that time will be excluded. 
crit = 0.05; 

new_times = lag_interp;
l = length(C14_samples(1,:));
j = 1;
ind = [];

% checks for lag times outside range of age models
for i = 1:length(new_times)
    
    % youngest C14 age older than lag time
    C1 = find(C14_samples(1,:)>new_times(i)); 
    % oldest C14 age younger than lag time
    C2 = find(C14_samples(end,:)<new_times(i)); 
    % youngest d18O age older than lag time
    d1 = find(d18O_samples(1,:)>new_times(i)); 
    % oldest d18O age older than lag time
    d2 = find(d18O_samples(end,:)<new_times(i)); 

    if length(C1)/l > crit || length(C2)/l > crit || length(d1)/l > crit || length(d2)/l > crit
        ind(j) = i;
        j = j + 1;
    end
end

new_times(ind) = []; % deletes lag times beyond range of age models

% returns index of C14 and d18O samples beyond range of new times
C14_ind = find(C14_samples(1,:)<new_times(1) & C14_samples(end,:)>new_times(end));
% returns index of d18O samples within the range of new times
d18O_ind = find(d18O_samples(1,:)<new_times(1) & d18O_samples(end,:)>new_times(end));



    



