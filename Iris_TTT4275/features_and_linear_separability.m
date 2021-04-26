clc
clear

%% Initializing and setup

x1all = load('class_1','-ascii'); % Iris Setosa
x2all = load('class_2','-ascii'); % Iris Versicolor
x3all = load('class_3','-ascii'); % Iris Virginica

num_plots = 4;
num_features = 4;

%% Smoother way of plotting
figure(1);
    for j = 1:num_features
       subplot(2,2,j);
       histogram([x1all(:, j); x2all(:, j); x3all(:, j)], 'BinWidth', 0.1);
       sgtitle("All iris'")
       ylabel("Quantity");
        if(mod(j,2))
          xlabel("Length");
          if(j < 3)
              title("Sepal length");
          else
              title("Petal length");
          end
       else
          xlabel("Width");
          if(j < 3)
              title("Sepal width");
          else
              title("Petal width");
          end
       end
    end
for i = 2:num_plots
    figure(i)
    for j = 1:num_features
        subplot(2, 2, j);
        if i == 2
            histogram(x1all(:, j), 'BinWidth', 0.1);
            sgtitle('Iris Setosa')
        elseif i == 3
            histogram(x2all(:, j), 'BinWidth', 0.1);
            sgtitle('Iris Versicolor')
        else
            histogram(x3all(:, j), 'BinWidth', 0.1);
            sgtitle('Iris Virginica')
        end
        
        ylabel("Quantity");
       if(mod(j,2))
          xlabel("Length");
          if(j < 3)
              title("Sepal length");
          else
              title("Petal length");
          end
       else
          xlabel("Width");
          if(j < 3)
              title("Sepal width");
          else
              title("Petal width");
          end
       end
    end
end


%% Take away the feature with most overlap between classes - *Vil si at det er Sepal length eller Sepal width, går for Sepal length i første omgang ;) *
% TODO: Bør lage en funksjon som tar inn hvilken features vi vil ha, for så
% å returnere classifieren.


% Setting up
N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;
D = 3;

% Loading data
xall_labeled = readtable('iris.csv');

% Set up training
x1_training_labeled = xall_labeled(1:N_training, :);
x2_training_labeled = xall_labeled(N+1:N + N_training, :);
x3_training_labeled = xall_labeled(2*N + 1:2*N + N_training, :);



x_training = [   x1_training_labeled.Var1 x1_training_labeled.Var2 x1_training_labeled.Var3 x1_training_labeled.Var4;
                x2_training_labeled.Var1 x2_training_labeled.Var2 x2_training_labeled.Var3 x2_training_labeled.Var4;
                x3_training_labeled.Var1 x3_training_labeled.Var2 x3_training_labeled.Var3 x3_training_labeled.Var4;];

            
features_needed = 2:4;
training_data_3f = get_training_data(x_training, features_needed, N_training, C);
W_3 = train_classifier(training_data_3f, C, size(features_needed, 2));
[conf_testing, conf_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W_3, N_training, N_test, C);
disp("Features: [Sepal width (cm), Petal length (cm), Petal width (cm)]")
disp('Testing')
disp(conf_testing)
disp('Training')
disp(conf_training)


testing_error_rate = 1 - (trace(conf_testing)/(N_test*C));
training_error_rate = 1 - (trace(conf_training)/(N_training*C));

disp('Error rate - testing')
disp(testing_error_rate)

disp('Error rate - training')
disp(training_error_rate)

disp("-------------------")
disp("-------------------")


features_needed = 3:4;
training_data_2f = get_training_data(x_training, features_needed, N_training, C);
W_2 = train_classifier(training_data_2f, C, size(features_needed, 2));
[conf_testing, conf_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W_2, N_training, N_test, C);
disp("Features: [Petal length (cm), Petal width (cm)]")
disp('Testing')
disp(conf_testing)
disp('Training')
disp(conf_training)


testing_error_rate = 1 - (trace(conf_testing)/(N_test*C));
training_error_rate = 1 - (trace(conf_training)/(N_training*C));

disp('Error rate - testing')
disp(testing_error_rate)

disp('Error rate - training')
disp(training_error_rate)

disp("-------------------")
disp("-------------------")

features_needed = 4;
training_data_1f = get_training_data(x_training, features_needed, N_training, C);
W_1 = train_classifier(training_data_1f, C, size(features_needed, 2));
[conf_testing, conf_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W_1, N_training, N_test, C);
disp("Features: [Petal width (cm)]")
disp('Testing')
disp(conf_testing)
disp('Training')
disp(conf_training)

testing_error_rate = 1 - (trace(conf_testing)/(N_test*C));
training_error_rate = 1 - (trace(conf_training)/(N_training*C));


disp('Error rate - testing')
disp(testing_error_rate)

disp('Error rate - training')
disp(training_error_rate)

disp("-------------------")
disp("-------------------")
