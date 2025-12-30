%%1: Initialize x,W,b where: X
x = randn(3,1); %x 3*1
W = randn(2,3); %W 2*3, 
b = randn(2, 1); % b 2*1

%%2: Ouput z = Wx+b
z = W * x + b;
disp(z)
%%3: Apply Sigmoid function" z = \sigma(x) = \frac{1}{1+e^{-z}}
% Code chuẩn
A = 1 ./ (1 + exp(-z));
disp(A)