close all
clear all
clc

projectdir = pwd;
outputdir_brazil = fullfile(projectdir,'BIGMACS_outputs','Brazil_Margin');
outputdir_atlantic = fullfile(projectdir,'BIGMACS_outputs','Atlantic');
addpath(fullfile(projectdir,'scripts'))

% 1 -> default Brazil Margin run
% 2 -> synthetic Brazil Margin d18O from Gebbie, 2012
% 3 -> Brazil Margin with end ages from Lund et al., (2015)
% 4 -> Brazil Margin with ITWA stack as alignment target
% 5 -> Atlantic run
% 6 -> Iberian Margin cores aligned to Eastern Equatorial Pacific stack
% 7 -> Iberian Margin stack (on depth scale) aligned to EEP stack
% 8 -> Bayesian Inversion to calculate lag directly between IM and EEP


run = 8;

% set times to calculate lag
lag_times = 10:2:18;


if run == 1 || run == 3 || run == 4
    % load d18O age models
    if run == 1
        d18O = load(fullfile(outputdir_brazil,'d18O','results.mat'));
    elseif run == 3
        d18O = load(fullfile(outputdir_brazil,'d18O Lund','results.mat'));
    elseif run == 4
        d18O = load(fullfile(outputdir_brazil,'d18O ITWA','results.mat'));
    end
    % load C14 age models
    C14 = load(fullfile(outputdir_brazil,'C14','results.mat'));
    % calculate lags
    lags = calculate_lag(C14,d18O,lag_times);
    % calculate lag stacks 
    [upper_stack] = calc_lag_stack(lags(2:4));
    [lower_stack] = calc_lag_stack(lags(5:7));
    [deep_stack] = calc_lag_stack(lags(8:10));
    [abyss_stack] = calc_lag_stack(lags(11:12));
    % calculate lag differences between lower intermediate and deep
    [diff_uplow] = calc_lag_diff(upper_stack.samples, lower_stack.samples);
    [diff_lowdeep] = calc_lag_diff(lower_stack.samples, deep_stack.samples);
    [diff_deepabyss] = calc_lag_diff(deep_stack.samples, abyss_stack.samples);
end

% load and calculate synthetic d18O and lags
if run == 2
    d18O = load(fullfile(outputdir_brazil,'d18O Gebbie','results.mat'));
    lags = calculate_lag_gebbie(d18O,lag_times);
end

% load Atlantic age models and calculate Atlantic lags
if run == 5
    d18O = load(fullfile(outputdir_atlantic,'d18O','results.mat'));
    C14 = load(fullfile(outputdir_atlantic,'C14','results.mat'));
    lags = calculate_lag(C14,d18O,lag_times);
end

if run == 8
    IM = load('BIGMACS_outputs\IM_vs_EEP\Iberian Margin_both_stack\stack.txt');
    EEP = load('BIGMACS_outputs\IM_vs_EEP\EEP_both_stack\stack.txt');
    ind = find(IM(:,1)==30);% truncate IM at at 30 ka BP
    IM(ind:end,:) = [];
    h = 0.13; % shift
    s = 1.01; % scale
    t = round(5:0.1:25,1); % time to calculate lag
    L = -5:0.01:5; % specify lags to iterate throughprior = 'G'; % U = Uniform, G = Gaussian
    prior = 'G'; % U = Uniform, G = Gaussian
    mu = -1; % mean for Gaussian, not used for Uniform
    prior_std = 2; % range for U, std for G
    % calculate posteriors with Gaussian Prior
    for j = 1:length(t)
        [postG(j,:),mean_lagG(j,:),upper_lagG(j,:),lower_lagG(j,:),max_probG(j)] = analytical(EEP,IM,t(j),h,s,prior,mu,prior_std,L);
    end
end






