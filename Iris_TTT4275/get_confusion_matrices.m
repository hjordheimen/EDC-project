function [confusion_matrix_testing, confusion_matrix_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W, N_training, N_test, C)
    
    confusion_matrix_testing = zeros(C, C);
    confusion_matrix_training = zeros(C, C);

    % Set up training
    x1_training = x1all(1:N_training, features_needed);
    x2_training = x2all(1:N_training, features_needed);
    x3_training = x3all(1:N_training, features_needed);

    % Set up tests
    x1_test = x1all(N_training + 1:end, features_needed);
    x2_test = x2all(N_training + 1:end, features_needed);
    x3_test = x3all(N_training + 1:end, features_needed);


    for i = 1:N_test
        % Extract samples
        x1 = x1_test(i, :)';
        x2 = x2_test(i, :)';
        x3 = x3_test(i, :)';
    
        % Classify samples
        x1_class = classifier(x1, W);
        x2_class = classifier(x2, W);
        x3_class = classifier(x3, W);

        % Update confusion matrix
        confusion_matrix_testing(1, x1_class) = confusion_matrix_testing(1, x1_class) + 1;
        confusion_matrix_testing(2, x2_class) = confusion_matrix_testing(2, x2_class) + 1;
        confusion_matrix_testing(3, x3_class) = confusion_matrix_testing(3, x3_class) + 1;
    end

    for i = 1:N_training
        % Extract samples
        x1 = x1_training(i, :)';
        x2 = x2_training(i, :)';
        x3 = x3_training(i, :)';

        % Classify samples
        x1_class = classifier(x1, W);
        x2_class = classifier(x2, W);
        x3_class = classifier(x3, W);

        % Update confusion matrix
        confusion_matrix_training(1, x1_class) = confusion_matrix_training(1, x1_class) + 1;
        confusion_matrix_training(2, x2_class) = confusion_matrix_training(2, x2_class) + 1;
        confusion_matrix_training(3, x3_class) = confusion_matrix_training(3, x3_class) + 1;
    end

end

