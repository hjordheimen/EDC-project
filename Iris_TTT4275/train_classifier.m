function W = train_classifier(training_data, C, D)
% Classifier consists of discriminant 
% functions on homogenous matrix form
% g = [W w_0]*[x' 1]'

    % Initial guess at weights
    W_0 = zeros(C,D);
    w_0 = [0 0 0]';

    % Homogenous form
    W_0 = [W_0 w_0];

    % Object function to be optimized
    f      = @(W) MSE(training_data, W);
    grad_f = @(W) grad_MSE(training_data, W);

    % Run steepest descent algorithm
    % Extract final iterate
    W_iterates = SteepestDescent(f, grad_f, W_0);
    W = W_iterates(:, end - D: end);
end