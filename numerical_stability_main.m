% run this code to test all solvers on simulated problem instances. This
% will save the results from the benchmark_solver function for all
% different solvers and also plot a histogram of the residuals and print
% the median time in the command window.

%% Set some options
iters = 5; % change to a higher value for better plots. iter = 1000 is a good choice for a nice plot
run_45_solvers = 0; % set to 1 to run all solvers. Since solvers 4XX are prohibitely slow it is 0 as default
addpath(genpath(pwd))

%% Define the problems etc
if run_45_solvers
    problem_names = {'302', '311', '303', '312', '405', ...
        '414', '423', '406', '415', '424', '433'}; % to run problems
    problem_legend = {'3-0-2', '3-1-1', '3-0-3', '3-1-2', '4-0-5', ...
        '4-1-4', '4-2-3', '4-0-6', '4-1-5', '4-2-4', '4-3-3'}; % for plotting
else
    problem_names = {'302', '311', '303', '312', '406', ...
        '415', '424', '433'};
    problem_legend = {'3-0-2', '3-1-1', '3-0-3', '3-1-2', '4-0-6', ...
        '4-1-5', '4-2-4', '4-3-3'};
end

% created directory to save results in
res_dir = 'results'; % directory to save results
res_name = 'results'; % name of result mat file
if ~exist('results','dir')
    mkdir(res_dir)
end

%% run the actual solvers
for i = 1:length(problem_names)
    prob = ['problem_3dreg_' problem_names{i}];
    solv = ['solver_3dreg_' problem_names{i}];
    fprintf('Problem: %s\n', prob);
    problem = str2func(prob);
    solv_fun = str2func(solv);
    res{i}.problem = prob;
    res{i}.stats = benchmark_solver(solv_fun,problem,iters);
end

% save the results
save(fullfile(res_dir,res_name), 'res');

%% plot the histograms

res_length = 4*iters; % to include same number of residuals for all solvers
figure(1); clf; % to plot our solvers
for i = 1:length(problem_names)
    [hist_y,hist_x] = hist(log10(res{i}.stats.all_res(randperm(length(res{i}.stats.all_res),res_length))),40);
    figure(1); plot(hist_x,hist_y/res_length); hold on;
end
figure(1); hold off;
xlabel('log_{10}(residual)');
title('Stability for solvers')
legend(problem_legend,'Interpreter','None')
axis([-16 4 0 0.15])
set(gca,'XTick',-16:2:2)


%% print the median times

fprintf('Median times for different solvers:\n')
for i = 1:length(problem_names)
    fprintf('%15s:   Time: %8.2f ms\n',...
        res{i}.problem,1000*median(res{i}.stats.time_taken))
end
