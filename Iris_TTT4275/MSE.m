function mse = MSE(training_data, W)
% Returns MSE of discriminant and target value given weights, W.
%
    N = size(training_data, 1);

    mse  = 0;
    for i = 1:N
        x_i = cell2mat(training_data(i, 1));
        t_i = cell2mat(training_data(i, 2));
        x_i = [x_i' 1]';    % Homogenous form

        
        z_i = W*x_i;
        g_i = 1./(1+exp(-z_i));

        mse = mse + 0.5*(g_i - t_i)'*(g_i - t_i);
    end
end
