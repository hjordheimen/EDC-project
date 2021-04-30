clc
clear

%% Set up
x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');

N          = size(x1all, 1); % Number of samples from each class
N_training = 30;             % Number of training samples from each class
N_test     = N - N_training; % Number of test samples from each class
C = 3;
D = 4;

% Loading data
xall_labeled = readtable('iris.csv');

% Set up training
x1_training_labeled = xall_labeled(1:N_training, :);
x2_training_labeled = xall_labeled(N+1:N + N_training, :);
x3_training_labeled = xall_labeled(2*N + 1:2*N + N_training, :);

% Target vectors
t1 = [1 0 0]';
t2 = [0 1 0]';
t3 = [0 0 1]';

% Storing each training sample and its target vector in a cell array
training_data = cell(N_training*C, 2);
for i = 1:N_training
   x1_i = [x1_training_labeled.Var1(i) x1_training_labeled.Var2(i) x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var1(i) x2_training_labeled.Var2(i) x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var1(i) x3_training_labeled.Var2(i) x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :)                = {x1_i, t1};
   training_data(i + N_training, :)   = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end


%% Linear classifier - Training
% Classifier consists of discriminant 
% functions on homogenous matrix form
% g = W*x

W = train_classifier(training_data, C, D);


%% Testing

[confusion_matrix_testing, confusion_matrix_training] = get_confusion_matrices(x1all, x2all, x3all, 1:D, W, N_training, N_test, C);

disp('Testing')
disp(confusion_matrix_testing)
disp('Training')
disp(confusion_matrix_training)

testing_error_rate  = 1 - (trace(confusion_matrix_testing)/(N_test*C));
training_error_rate = 1 - (trace(confusion_matrix_training)/(N_training*C));


disp('Error rate - testing')
disp(testing_error_rate)

disp('Error rate - training')
disp(training_error_rate)

disp('-------------------------')
disp('--Reversed sample Order--')
disp('-------------------------')

%% Last 30 samples for training, 20 first as tests
clear

%% Set up
x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');

N          = size(x1all, 1); % Number of samples from each class
N_training = 30;             % Number of training samples from each class
N_test     = N - N_training; % Number of test samples from each class
C = 3;
D = 4;

% Loading data
xall_labeled = readtable('iris.csv');

% Set up training
x1_training_labeled = xall_labeled(N_test + 1:end, :);
x2_training_labeled = xall_labeled(N+ N_test + 1:N + N_test+ N_training, :);
x3_training_labeled = xall_labeled(2*N + N_test + 1:2*N + N_test + N_training, :);

% Target vectors
t1 = [1 0 0]';
t2 = [0 1 0]';
t3 = [0 0 1]';

% Storing each training sample and its target vector in a cell array
training_data = cell(N_training*C, 2);
for i = 1:N_training
   x1_i = [x1_training_labeled.Var1(i) x1_training_labeled.Var2(i) x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var1(i) x2_training_labeled.Var2(i) x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var1(i) x3_training_labeled.Var2(i) x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :)                = {x1_i, t1};
   training_data(i + N_training, :)   = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Extracting training data without labels
x1_training = x1all(N_test + 1:end, :);
x2_training = x2all(N_test + 1:end, :);
x3_training = x3all(N_test + 1:end, :);

% Set up tests
x1_test = x1all(1:N_test, :);
x2_test = x2all(1:N_test, :);
x3_test = x3all(1:N_test, :);



%% Linear classifier - Training
% Classifier consists of discriminant 
% functions on homogenous matrix form
% g = W*x

W = train_classifier(training_data, C, D);

%% Testing

confusion_matrix_testing  = zeros(C, C);
confusion_matrix_training = zeros(C, C);

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

disp('Testing')
disp(confusion_matrix_testing)
disp('Training')
disp(confusion_matrix_training)


testing_error_rate  = 1 - (trace(confusion_matrix_testing)/(N_test*C));
training_error_rate = 1 - (trace(confusion_matrix_training)/(N_training*C));

disp('Error rate - testing')
disp(testing_error_rate)

disp('Error rate - training')
disp(training_error_rate)
