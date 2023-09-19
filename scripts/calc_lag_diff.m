function [diff] = calc_lag_diff(lag1, lag2)

% calculate difference between lag stacks
diff.samples = lag1 - lag2;
diff.upper = quantile(diff.samples,0.975,2);
diff.lower = quantile(diff.samples,0.025,2);
diff.average = mean(diff.samples,2);
end