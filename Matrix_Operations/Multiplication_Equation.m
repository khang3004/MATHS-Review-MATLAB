%Define Matrix A   (Coefficient Matrix)
A = [1 2 3; 
    4 5 6;
    7 8 10;]


% Define vector b (consstant vector)

%Note: Use semicolon to make it a column
B = [9; 24; 30];

% Solve for x using Left Devision Operator
x = A \ B

%Ouput result
disp("SOLUTION for The Equation system be:");
disp(x);

% Define Augmented Matrix
Aug = [1 2 3 9;
       4 5 6 24;
       7 8 10 30;];
% Compute Reduced Row Echolon Form
[R, pivot_vars] = rref(Aug);

%Display the result
disp("Reduced Echelon Form be:");
disp(R);