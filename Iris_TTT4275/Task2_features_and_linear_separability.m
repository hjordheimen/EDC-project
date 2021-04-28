clc
clear

%% Initializing and setup

x1all = load('class_1','-ascii'); % Iris Setosa
x2all = load('class_2','-ascii'); % Iris Versicolor
x3all = load('class_3','-ascii'); % Iris Virginica

num_plots = 4;
num_features = 4;


%% Producing histograms of the classes
figure(1);
subplot(4,1,1);
for i = 1:num_features
    histogram([x1all(:, i); x2all(:, i); x3all(:, i)], 'BinWidth', 0.2);
    hold on;
end
title("All iris'");
xlabel("Size [m^{-2}]");
ylabel("Quantity");
legend("Sepal length", "Sepal width", "Petal length", "Petal width");
xlim([0, 8]);
ylim([0, 40]);

subplot(4,1,2);
for i = 1:num_features
    histogram(x1all(:, i), 'BinWidth', 0.2);
    hold on;
end
title('Iris Setosa')
xlabel("Size [m^{-2}]");
ylabel("Quantity");
legend("Sepal length", "Sepal width", "Petal length", "Petal width");
xlim([0, 8]);
ylim([0, 40]);

subplot(4,1,3);
for i = 1:num_features
    histogram(x2all(:, i), 'BinWidth', 0.2);
    hold on;
end
title('Iris Versicolor')
xlabel("Size [m^{-2}]");
ylabel("Quantity");
legend("Sepal length", "Sepal width", "Petal length", "Petal width");
xlim([0, 8]);
ylim([0, 40]);

subplot(4,1,4);
for i = 1:num_features
    histogram(x3all(:, i), 'BinWidth', 0.2);
    hold on;
end
title('Iris Virginica');
xlabel("Size [m^{-2}]");
ylabel("Quantity");
legend("Sepal length", "Sepal width", "Petal length", "Petal width");
xlim([0, 8]);
ylim([0, 40]);

sgtitle("Histograms of the classes");

%% Producing histograms for each feature
feature_names = ["Sepal length", "Sepal width", "Petal length", "Petal width"];
figure(2);
for i = 1:num_features
   subplot(4,1,i);
   histogram(x1all(:, i), 'BinWidth', 0.2);
   hold on;
   histogram(x2all(:, i), 'BinWidth', 0.2);
   hold on;
   histogram(x3all(:, i), 'BinWidth', 0.2);
   hold on;
   title(feature_names(i));
   xlabel("Size [m^{-2}]");
   ylabel("Quantity");
   legend("Iris Setosa", "Iris Versicolor", "Iris Virginica");
   xlim([0, 8]);
   ylim([0, 40]);
end

sgtitle("Histograms for each feature, whole data set");



%% Take away the feature with most overlap between classes - *Vil si at det er Sepal length eller Sepal width, går for Sepal length i første omgang ;) *

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

%% Reducing feature space, taking away feature: Sepal width
% Features left: Sepal length, Petal length, Petal width
            
features_needed = [1,3:4];
training_data_3f = get_training_data(x_training, features_needed, N_training, C);
W_3 = train_classifier(training_data_3f, C, size(features_needed, 2));
[conf_testing, conf_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W_3, N_training, N_test, C);
disp("Features: [Sepal length (cm), Petal length (cm), Petal width (cm)]")
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

%% Reducing feature space, taking away feature: Sepal length, Sepal width
% Features left: Petal length, Petal width

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

%% Reducing feature space, taking away features: Sepal length, Sepal width, Petal width
% Features left: Petal length

features_needed = 3;
training_data_1f = get_training_data(x_training, features_needed, N_training, C);
W_1 = train_classifier(training_data_1f, C, size(features_needed, 2));
[conf_testing, conf_training] = get_confusion_matrices(x1all, x2all, x3all, features_needed, W_1, N_training, N_test, C);
disp("Features: [Petal length (cm)]")
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
