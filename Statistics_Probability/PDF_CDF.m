%% SECTION 1: Setup Environment
clc; clear; close all;

% Định nghĩa phân phối chuẩn với Sigma rất nhỏ (Tập trung cao độ)
mu = 0;
sigma = 0.1; % Độ lệch chuẩn nhỏ -> PDF sẽ rất cao

x = linspace(mu - 4*sigma, mu + 4*sigma, 1000);

%% SECTION 2: Calculate PDF & CDF
pdf_vals = normpdf(x, mu, sigma);
cdf_vals = normcdf(x, mu, sigma);

%% SECTION 3: Visualization (Decoding Stanley Chan)
figure('Name', 'PDF vs CDF Analysis', 'Color', 'w', 'Position', [100 100 1000 500]);

% Plot 1: PDF (The Density)
subplot(1, 2, 1);
plot(x, pdf_vals, 'LineWidth', 2, 'Color', '#D95319');
yline(1, 'k--', 'Probability Limit = 1');
title('Probability Density Function (PDF)');
xlabel('x'); ylabel('Density f_X(x)');
grid on;

% Highlight đỉnh
max_pdf = max(pdf_vals);
text(mu, max_pdf, sprintf('Max Density = %.2f (> 1!)', max_pdf), ...
    'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'Color', 'r', 'FontWeight', 'bold');

subtitle('Stanley Chan: "PDF is Probability per unit length"');

% Plot 2: CDF (The Probability)
subplot(1, 2, 2);
plot(x, cdf_vals, 'LineWidth', 2, 'Color', '#0072BD');
yline(1, 'k--', 'Max Probability = 1');
title('Cumulative Distribution Function (CDF)');
xlabel('x'); ylabel('Probability P(X \le x)');
grid on;
ylim([-0.1 1.2]);

subtitle('CDF always stays within [0, 1]');

%% SECTION 4: Why CDF is useful? (Calculation)
% Bài toán: Tính xác suất X nằm trong khoảng [-0.1, 0.1]
% Cách 1: Tích phân PDF (Mô phỏng bằng hình thang)
prob_integral = trapz(x(x>=-0.1 & x<=0.1), pdf_vals(x>=-0.1 & x<=0.1));

% Cách 2: Dùng CDF (Phép trừ đơn giản)
prob_cdf = normcdf(0.1, mu, sigma) - normcdf(-0.1, mu, sigma);

fprintf('--- SO SÁNH HIỆU QUẢ ---\n');
fprintf('Xác suất tính bằng tích phân PDF: %.6f\n', prob_integral);
fprintf('Xác suất tính bằng hiệu CDF:      %.6f (Nhanh & Chính xác)\n', prob_cdf);