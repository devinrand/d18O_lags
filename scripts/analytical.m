function [post,mean_lag,upper_lag,lower_lag,max_prob] = analytical(stack1,stack2,time,h,s,prior,mu,range,L)

% calculates the lag between two stacks using a Bayesian inversion
% post = posterior distribution for each time step
% mean_lag = mean lag 
% upper_lag = upper 95% CI
% lower_lag = lower 95% CI
% max_prob = mode

mu1 = interp1(stack1(:,1),stack1(:,2),time);
s1 = interp1(stack1(:,1),stack1(:,3),time);

% Posterior
if strcmp(prior,'U')==1
    f = @(mu2, s2,L) normpdf(0, mu1 - (mu2-h)/s, sqrt(s1^2+((s2^2)/s^2)))*unifpdf(L, -range,range);
elseif strcmp(prior,'G')==1
    f = @(mu2, s2,L) normpdf(0, mu1 - (mu2-h)/s, sqrt(s1^2+((s2^2)/s^2)))*normpdf(L, mu, range);
end


for i = 1:length(L)
    mu2 = interp1(stack2(:,1),stack2(:,2),time-L(i));
    s2 = interp1(stack2(:,1),stack2(:,3),time-L(i));
    post(i) = f(mu2,s2,L(i));
end
post(isnan(post))=0;
post = post/sum(post);


% calcualte CDF to find quantiles
post_CDF = [];
for i = 1:length(post)
    post_CDF(i) = sum(post(1:i));
end

mean_lag = sum(L.*post);
lower_lag = L(find(post_CDF<=0.025,1,'last'));
upper_lag = L(find(post_CDF<=0.975,1,'last'));
max_prob = L(post==max(post));
