function W = train_classifier(training_data, C, D)
%% Linear classifier - Training
    % g = W_t*x_t, W_t = [W j] --> g = [W w_0]*[x' 1]'

    W_0 = zeros(C,D);
    w_0 = [0 0 0]';

    % Homogenous form
    W_0 = [W_0 w_0]; % Initialized 

    f = @(W) MSE(training_data, W);
    grad_f = @(W) grad_MSE(training_data, W);

    W_iterates = SteepestDescent(f, grad_f, W_0);
    W = W_iterates(:, end - D: end);
end