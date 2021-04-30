function training_data = get_training_data(x_training, features_needed, N_training, C)

    % Targets
    t1 = [1 0 0]';
    t2 = [0 1 0]';
    t3 = [0 0 1]';

    % Storing each training sample and its target vector in a cell array
    training_data = cell(N_training*C, 2);
    for i = 1:N_training
       x1_i = x_training(i, (features_needed))'; 
       x2_i = x_training(i + N_training, (features_needed))'; 
       x3_i = x_training(i + 2*N_training, (features_needed))'; 
       training_data(i, :) = {x1_i, t1};
       training_data(i + N_training, :) = {x2_i, t2};
       training_data(i + 2*N_training, :) = {x3_i, t3};
    end
end

