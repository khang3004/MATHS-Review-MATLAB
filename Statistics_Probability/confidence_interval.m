%% SECTION 1: Setup Simulation
clc; clear; close all;
rng(123); % Fixed seed for reproducibility

% 1. Thông số của "Chúa" (True Parameters)
true_mean = 50;
true_std = 10;

% 2. Thông số thí nghiệm
n_experiments = 100;    % Lặp lại thí nghiệm 100 lần
sample_size = 30;       % Mỗi lần lấy 30 mẫu
alpha = 0.05;           % Độ tin cậy 95%

% Lưu trữ kết quả
ci_lower = zeros(n_experiments, 1);
ci_upper = zeros(n_experiments, 1);
sample_means = zeros(n_experiments, 1);
captured = false(n_experiments, 1); % Biến logic: True Mean có nằm trong CI ko?

%% SECTION 2: Run Experiments Loop
for i = 1:n_experiments
    % Giả lập lấy mẫu từ phân phối chuẩn
    data = normrnd(true_mean, true_std, [sample_size, 1]);
    
    % Tính toán thống kê mẫu
    x_bar = mean(data);
    s = std(data);
    
    % Tính Confidence Interval (dùng T-distribution vì chưa biết sigma thực tế)
    % Công thức: Mean +/- t_score * (s / sqrt(n))
    se = s / sqrt(sample_size); % Standard Error
    t_crit = tinv(1 - alpha/2, sample_size - 1); % Critical T-value
    
    ci_lower(i) = x_bar - t_crit * se;
    ci_upper(i) = x_bar + t_crit * se;
    sample_means(i) = x_bar;
    
    % Kiểm tra xem True Mean có nằm trong khoảng này không
    if true_mean >= ci_lower(i) && true_mean <= ci_upper(i)
        captured(i) = true;
    else
        captured(i) = false;
    end
end

%% SECTION 3: Visualization (The "Aha!" Moment)
figure('Name', 'Visualizing Confidence Intervals', 'Color', 'w', 'Position', [100 100 800 600]);
hold on;

% Vẽ đường True Mean (Cột mốc sự thật)
yline(true_mean, 'k-', 'True Mean (50)', 'LineWidth', 2);

% Vẽ từng khoảng CI
for i = 1:n_experiments
    if captured(i)
        color = '#0072BD'; % Blue: Chứa True Mean (Đúng)
        style = '-';
    else
        color = '#D95319'; % Red: Không chứa True Mean (Sai lầm ngẫu nhiên)
        style = '--';
        % Highlight điểm mean của trường hợp sai
        plot(i, sample_means(i), 'x', 'Color', color, 'MarkerSize', 8, 'LineWidth', 2);
    end
    
    % Vẽ đoạn thẳng CI
    line([i i], [ci_lower(i) ci_upper(i)], 'Color', color, 'LineStyle', style, 'LineWidth', 1.5);
    % Vẽ điểm mean mẫu
    plot(i, sample_means(i), '.', 'Color', color, 'MarkerSize', 10);
end

title(['Simulation of ' num2str(n_experiments) ' Confidence Intervals (95%)']);
xlabel('Experiment Index (1 to 100)');
ylabel('Values');
grid on;
ylim([40 60]);

% Tính tỷ lệ thực tế
capture_rate = sum(captured) / n_experiments * 100;
subtitle(['Red lines missed the True Mean. Actual Capture Rate: ' num2str(capture_rate) '%']);

hold off;

%% SECTION 4: Senior Insight Output
fprintf('--- KẾT QUẢ MÔ PHỎNG ---\n');
fprintf('Số thí nghiệm: %d\n', n_experiments);
fprintf('Số lần CI chứa đúng True Mean: %d\n', sum(captured));
fprintf('Số lần CI bị trượt (Type I Error): %d\n', sum(~captured));
fprintf('---------------------------------\n');
fprintf('INSIGHT: Bạn thấy đấy, dù quy trình của chúng ta chuẩn 95%%,\n');
fprintf('vẫn sẽ có khoảng 5%% số lần (các vạch đỏ) ta kết luận sai.\n');
fprintf('Đó là rủi ro thống kê không thể tránh khỏi.\n');
%%  SECTION 5: Bayes Error & Optimal Capacity (involves Efficient Opacity)


