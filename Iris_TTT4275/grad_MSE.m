function grad_mse = grad_MSE(training_data, W)
% Evaluates the gradient of the MSE function w.r.t W 
% for the linear discriminant classifier given 
% the labeled training data and the weights W.

    N = size(training_data, 1);

    grad_mse  = 0;
    for i = 1:N
        x_i = cell2mat(training_data(i, 1));
        t_i = cell2mat(training_data(i, 2));
        x_i = [x_i' 1]';    % Homogenous form
        
        z_i = W*x_i;
        g_i = 1./(1+exp(-z_i));

        grad_mse = grad_mse + ((g_i - t_i).*g_i.*(1 - g_i))*(x_i');
    end
end

