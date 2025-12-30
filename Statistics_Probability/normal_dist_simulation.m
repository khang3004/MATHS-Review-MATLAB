%% SECTION 0: GAUSSIAN distribution on MY BOOKS 
%GENERATE Stadard Gaussian PDF & CDF
x = linspace(-5, 5, 1000);
f = normpdf(x,0,1);
F = normcdf(x,0,1);
figure; plot(x, f);
figure; plot(x, F);

%% SECTION 1: Setup Environment
% Clean workspace to ensure reproducibility (Chuẩn hóa quy trình)
clc; clear; close all;

%% SECTION 2: Define Parameters for Normal Distribution
% Giả sử thời gian phản hồi trung bình là 200ms, độ lệch chuẩn là 30ms
mu = 200;       % Mean (Expectation)
sigma = 30;     % Standard Deviation

% Tạo một dải giá trị x (thời gian) để vẽ đồ thị
x = linspace(mu - 4*sigma, mu + 4*sigma, 1000);

%% SECTION 3: Calculate PDF and CDF
% PDF: Probability Density Function (Mật độ xác suất)
pdf_values = normpdf(x, mu, sigma);

% CDF: Cumulative Distribution Function (Xác suất tích lũy)
cdf_values = normcdf(x, mu, sigma);

%% SECTION 4: Visualization (Data Science Standard)
figure('Name', 'Server Response Time Analysis', 'Color', 'w');

% Plot 1: PDF
subplot(2, 1, 1);
plot(x, pdf_values, 'LineWidth', 2, 'Color', '#0072BD');
grid on;
title('Probability Density Function (PDF) - Normal Distribution');
xlabel('Response Time (ms)');
ylabel('Density');
xline(mu, '--r', 'Mean', 'LineWidth', 1.5); % Đánh dấu Mean
legend('Distribution', 'Mean (200ms)');

% Plot 2: CDF
subplot(2, 1, 2);
plot(x, cdf_values, 'LineWidth', 2, 'Color', '#D95319');
grid on;
title('Cumulative Distribution Function (CDF)');
xlabel('Response Time (ms)');
ylabel('Cumulative Probability');

%% SECTION 5: Practical Calculation (Bài toán thực tế)
% Câu hỏi: Xác suất để Server phản hồi chậm hơn 250ms là bao nhiêu?
% P(X > 250) = 1 - P(X <= 250) = 1 - CDF(250)

threshold = 250;
prob_slow = 1 - normcdf(threshold, mu, sigma);

fprintf('--- KẾT QUẢ PHÂN TÍCH ---\n');
fprintf('Mean Response Time: %.2f ms\n', mu);
fprintf('Standard Deviation: %.2f ms\n', sigma);
fprintf('Probability of response > %d ms is: %.4f (approx %.2f%%)\n', ...
    threshold, prob_slow, prob_slow*100);

% Giải thích kết quả theo ngôn ngữ IELTS/Academic:
% "Given a normal distribution with a mean of 200 and a standard deviation of 30,
% there is approximately a 4.78% probability that the response time will exceed 250ms."