% Tạo dữ liệu giả lập (như trong ảnh)
N = 20000; M = 100000;
A = randn(N, M);
B = randn(M, N);

% --- CÁCH CHẬM (Naive) ---
tic;
res_slow = trace(A * B);
time_slow = toc;
fprintf('Cách chậm: %.4f giây\n', time_slow);

% --- CÁCH NHANH (Senior) ---
tic;
% B' là chuyển vị của B
% A .* B' là nhân từng phần tử tương ứng
% sum(sum(...)) để cộng toàn bộ các phần tử trong ma trận kết quả
res_fast = sum(sum(A .* B')); 
time_fast = toc;

fprintf('Cách nhanh: %.4f giây\n', time_fast);
fprintf('Tăng tốc gấp: %.1f lần\n', time_slow / time_fast);