function [stack] = calc_lag_stack(group)

% calculate lag stack for the given depth interval

for j = 1:length(group(1).samples(1,:))
    lag_combo = [];
    for i = 1:length(group)
        lag_combo(:,i) = group(i).samples(:,j);
    end
    stack.samples(:,j) = mean(lag_combo,2);
end

stack.upper = quantile(stack.samples,0.975,2);
stack.lower = quantile(stack.samples,0.025,2);
stack.average = mean(stack.samples,2);
end