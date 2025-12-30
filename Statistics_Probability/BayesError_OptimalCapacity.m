%% SECTION 1: Setup "God Mode" Data
clc; clear; close all;
rng(42);

% 1. Hàm số thật (True Function - The Truth)
% y = sin(2*pi*x) + noise (Hàm này phức tạp hơn bậc 2 nhiều)

% 2. Tạo dữ liệu train (có nhiễu - Bayes Error source)
N = 20; % Chỉ có 20 điểm dữ liệu
X_train = sort(rand(N, 1));
sigma = 0.3; % Noise level
y_train = true_func(X_train) + sigma * randn(N, 1);

% Tạo dữ liệu test (dày đặc để vẽ đường cong)
X_test = linspace(0, 1, 1000)';
y_true = true_func(X_test);

%% SECTION 2: Model Capacity Simulation
degrees = [1, 3, 15]; % Các mức Capacity: Thấp (Underfit), Vừa, Cao (Overfit)
colors = {'#D95319', '#77AC30', '#0072BD'};
titles = {'Low Capacity (Degree 1)', 'Optimal Capacity (Degree 3)', 'High Capacity (Degree 15)'};

figure('Name', 'Model Capacity & Generalization', 'Color', 'w', 'Position', [100 100 1200 400]);

for i = 1:length(degrees)
    deg = degrees(i);
    subplot(1, 3, i);
    hold on;
    
    % Vẽ dữ liệu train (Chấm tròn)
    scatter(X_train, y_train, 50, 'k', 'filled', 'MarkerFaceAlpha', 0.5);
    
    % Vẽ hàm thật (Đường mờ)
    plot(X_test, y_true, 'k--', 'LineWidth', 1, 'Color', [0.7 0.7 0.7]);
    
    % Train mô hình (Polynomial Fit)
    p = polyfit(X_train, y_train, deg);
    y_pred = polyval(p, X_test);
    
    % Vẽ mô hình học được
    plot(X_test, y_pred, 'Color', colors{i}, 'LineWidth', 2.5);
    
    title(titles{i});
    ylim([-2 2]);
    if i == 1
        legend('Training Data', 'True Function (Bayes Limit)', 'Model Prediction', 'Location', 'southwest');
    end
    grid on;
end

%% SECTION 3: Explanation Output
fprintf('--- INSIGHT VỀ CAPACITY ---\n');
fprintf('1. Low Capacity (Bậc 1): Đường thẳng đuột. Không bắt được dạng hình sin. (Underfitting)\n');
fprintf('2. Optimal Capacity (Bậc 3): Cong vừa phải. Bám sát quy luật thật.\n');
fprintf('3. High Capacity (Bậc 15): Uốn éo điên cuồng để đi qua từng điểm dữ liệu. (Overfitting)\n');
fprintf('   -> Train Error cực thấp, nhưng Test Error sẽ cực cao.\n');