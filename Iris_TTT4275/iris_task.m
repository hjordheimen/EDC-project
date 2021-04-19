clc
clear

%% Set up

x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');



N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;
D = 4;




% Loading data
xall_labeled = readtable('iris.csv');

% Set up training
x1_training_labeled = xall_labeled(1:N_training, :);
x2_training_labeled = xall_labeled(N+1:N + N_training, :);
x3_training_labeled = xall_labeled(2*N + 1:2*N + N_training, :);

t1 = [1 0 0]';
t2 = [0 1 0]';
t3 = [0 0 1]';

training_data = cell(N_training*C, 2);
for i = 1:N_training
   x1_i = [x1_training_labeled.Var1(i) x1_training_labeled.Var2(i) x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var1(i) x2_training_labeled.Var2(i) x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var1(i) x3_training_labeled.Var2(i) x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :) = {x1_i, t1};
   training_data(i + N_training, :) = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Set up training, again...
x1_training = x1all(1:N_training, :);
x2_training = x2all(1:N_training, :);
x3_training = x3all(1:N_training, :);

% Set up tests
x1_test = x1all(N_training + 1:end, :);
x2_test = x2all(N_training + 1:end, :);
x3_test = x3all(N_training + 1:end, :);



%% Linear classifier - Training

% g = W_t*x_t, W_t = [W j] --> g = [W w_0]*[x' 1]'

W_0 = zeros(3,4);
w_0 = [0 0 0]';

% Homogenous form
W_0 = [W_0 w_0]; % Initialized 

f = @(W) MSE(training_data, W);
grad_f = @(W) grad_MSE(training_data, W);

W_iterates = SteepestDescent(f, grad_f, W_0);
W = W_iterates(:, end - D: end);


%% Testing

confusion_matrix_testing = zeros(C, C);
confusion_matrix_training = zeros(C, C);


for i = 1:N_test
    x1 = x1_test(i, :)';
    x2 = x2_test(i, :)';
    x3 = x3_test(i, :)';
    
    x1_class = classifier(x1, W);
    x2_class = classifier(x2, W);
    x3_class = classifier(x3, W);
    
    confusion_matrix_testing(1, x1_class) = confusion_matrix_testing(1, x1_class) + 1;
    confusion_matrix_testing(2, x2_class) = confusion_matrix_testing(2, x2_class) + 1;
    confusion_matrix_testing(3, x3_class) = confusion_matrix_testing(3, x3_class) + 1;
end

for i = 1:N_training
    x1 = x1_training(i, :)';
    x2 = x2_training(i, :)';
    x3 = x3_training(i, :)';
    
    x1_class = classifier(x1, W);
    x2_class = classifier(x2, W);
    x3_class = classifier(x3, W);
    
    confusion_matrix_training(1, x1_class) = confusion_matrix_training(1, x1_class) + 1;
    confusion_matrix_training(2, x2_class) = confusion_matrix_training(2, x2_class) + 1;
    confusion_matrix_training(3, x3_class) = confusion_matrix_training(3, x3_class) + 1;
end
disp('Testing')
disp(confusion_matrix_testing)
disp('Training')
disp(confusion_matrix_training)

testing_error_count = 0;
training_error_count = 0;


for i = 1:C
    testing_error_count = testing_error_count +  N_test - confusion_matrix_testing(i, i);
    training_error_count = training_error_count + N_training - confusion_matrix_training(i, i);
end

disp('Number of errors - testing')
disp(testing_error_count)

disp('Number of errors - training')
disp(training_error_count)

disp('------------------')
disp('--Reversed Order--')
disp('------------------')

%% Last 30 samples for training, 20 first as tests

clear

%% Set up

x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');



N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;
D = 4;




% Loading data
xall_labeled = readtable('iris.csv');

% Set up training
x1_training_labeled = xall_labeled(N_test + 1:end, :);
x2_training_labeled = xall_labeled(N+ N_test + 1:N + N_test+ N_training, :);
x3_training_labeled = xall_labeled(2*N + N_test + 1:2*N + N_test + N_training, :);

t1 = [1 0 0]';
t2 = [0 1 0]';
t3 = [0 0 1]';

training_data = cell(N_training*C, 2);
for i = 1:N_training
   x1_i = [x1_training_labeled.Var1(i) x1_training_labeled.Var2(i) x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var1(i) x2_training_labeled.Var2(i) x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var1(i) x3_training_labeled.Var2(i) x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :) = {x1_i, t1};
   training_data(i + N_training, :) = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Set up training, again...
x1_training = x1all(N_test + 1:end, :);
x2_training = x2all(N_test + 1:end, :);
x3_training = x3all(N_test + 1:end, :);

% Set up tests
x1_test = x1all(1:N_test, :);
x2_test = x2all(1:N_test, :);
x3_test = x3all(1:N_test, :);



%% Linear classifier - Training

% g = W_t*x_t, W_t = [W j] --> g = [W w_0]*[x' 1]'

W_0 = zeros(3,4);
w_0 = [0 0 0]';

% Homogenous form
W_0 = [W_0 w_0]; % Initialized 

f = @(W) MSE(training_data, W);
grad_f = @(W) grad_MSE(training_data, W);

W_iterates = SteepestDescent(f, grad_f, W_0);
W = W_iterates(:, end - D: end);


%% Testing

confusion_matrix_testing = zeros(C, C);
confusion_matrix_training = zeros(C, C);


for i = 1:N_test
    x1 = x1_test(i, :)';
    x2 = x2_test(i, :)';
    x3 = x3_test(i, :)';
    
    x1_class = classifier(x1, W);
    x2_class = classifier(x2, W);
    x3_class = classifier(x3, W);
    
    confusion_matrix_testing(1, x1_class) = confusion_matrix_testing(1, x1_class) + 1;
    confusion_matrix_testing(2, x2_class) = confusion_matrix_testing(2, x2_class) + 1;
    confusion_matrix_testing(3, x3_class) = confusion_matrix_testing(3, x3_class) + 1;
end

for i = 1:N_training
    x1 = x1_training(i, :)';
    x2 = x2_training(i, :)';
    x3 = x3_training(i, :)';
    
    x1_class = classifier(x1, W);
    x2_class = classifier(x2, W);
    x3_class = classifier(x3, W);
    
    confusion_matrix_training(1, x1_class) = confusion_matrix_training(1, x1_class) + 1;
    confusion_matrix_training(2, x2_class) = confusion_matrix_training(2, x2_class) + 1;
    confusion_matrix_training(3, x3_class) = confusion_matrix_training(3, x3_class) + 1;
end
disp('Testing')
disp(confusion_matrix_testing)
disp('Training')
disp(confusion_matrix_training)

testing_error_count = 0;
training_error_count = 0;


for i = 1:C
    testing_error_count = testing_error_count +  N_test - confusion_matrix_testing(i, i);
    training_error_count = training_error_count + N_training - confusion_matrix_training(i, i);
end

disp('Number of errors - testing')
disp(testing_error_count)

disp('Number of errors - training')
disp(training_error_count)



% function t_i = generateTargetVectorb(labelStr)
%     if labelStr == 'Iris-setosa'
%         t_i = [1 0 0]';
%     elseif labelStr == 'Iris-versicolor'
%         t_i = [0 1 0]';
%     else
%         t_i = [0 0 1]';
%     end
% end
