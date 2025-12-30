clc; clear; close all;
rng(42);

true_sigma = 2.0;
bayes_error = true_sigma^2; % 4.0

% Thử với các kích thước mẫu khác nhau
sample_sizes = [100, 10000, 1000000, 10000000];

fprintf('Lý thuyết Bayes Error: %.4f\n', bayes_error);
fprintf('------------------------------------------------\n');

for N = sample_sizes
    % Sinh nhiễu
    epsilon = true_sigma * randn(N, 1);
    
    % Tính MSE thực tế trên mẫu này
    mse_calculated = mean(epsilon.^2);
    
    fprintf('Với N = %-10d -> MSE = %.5f (Sai lệch: %+.5f)\n', ...
        N, mse_calculated, mse_calculated - bayes_error);
end