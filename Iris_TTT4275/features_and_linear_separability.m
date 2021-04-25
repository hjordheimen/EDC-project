clc
clear

%% Initializing and setup

x1all = load('class_1','-ascii'); % Iris Setosa
x2all = load('class_2','-ascii'); % Iris Versicolor
x3all = load('class_3','-ascii'); % Iris Virginica



%% Histogram for each feature as a whole

% Don't know how many bins we should us.. Using 'BinWidth', 0.1 for now.

figure(1);
sgtitle("All iris'")
% Sepal length histogram
subplot(221);
h_sepal_length = histogram([x1all(:, 1); x2all(:, 1); x3all(:, 1)], 'BinWidth', 0.1);
% disp(h_sepal_length)
title('Sepal length histogram');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram([x1all(:, 2); x2all(:, 2); x3all(:, 2)], 'BinWidth', 0.1);
% disp(h_sepal_width)
title('Sepal width histogram');

% Petal length histogram
subplot(223);
h_petal_length = histogram([x1all(:, 3); x2all(:, 3); x3all(:, 3)], 'BinWidth', 0.1);
% disp(h_petal_length)
title('Petal length histogram')

% Petal width histogram
subplot(224);
h_petal_width = histogram([x1all(:, 4); x2all(:, 4); x3all(:, 4)], 'BinWidth', 0.1);
% disp(h_petal_width)
title('Petal width histogram');


% Usikker på om vi skal normalisere hvert enkelt histogram, slik at vi kan
% sammenligne dem på en god måte, for så å kutte en feature...

% Usikker på hvordan vi skal lage histogram for hver klasse. Er det slik at
% vi skal lage Histogram for hver av sepal og petal for hver klasse?

% Etter å ha tenkt litt, så tror jeg de mener at vi skal gjøre det over for
% hver enkelt klasse itillegg. Da gir hvertfall 2.c) veldig mening mtp
% "Comment on the property of the linear separability both as a whole and 
% for the three separate classes."

% Vi kan eventuelt plotte alle klasse histogrammene sammen, for å se
% hvordan de fordeler seg (med farger :D).


% HUSK: Attributes -> [Sepal length (cm), Sepal width (cm), Petal length (cm), Petal width (cm), Type of class]. 

%% Iris Setosa histogram
figure(2);
sgtitle('Iris Setosa')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x1all(:, 1), 'BinWidth', 0.1);
% disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x1all(:, 2), 'BinWidth', 0.1);
% disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x1all(:, 3), 'BinWidth', 0.1);
% disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x1all(:, 4), 'BinWidth', 0.1);
% disp(h_petal_width)
title('Petal width');


%% Iris Versicolor histogram

figure(3);
sgtitle('Iris Versicolor')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x2all(:, 1), 'BinWidth', 0.1);
% disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x2all(:, 2), 'BinWidth', 0.1);
% disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x2all(:, 3), 'BinWidth', 0.1);
% disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x2all(:, 4), 'BinWidth', 0.1);
% disp(h_petal_width)
title('Petal width');

%% Iris Virginica histogram
figure(4);
sgtitle('Iris Virginica')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x3all(:, 1), 'BinWidth', 0.1);
% disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x3all(:, 2), 'BinWidth', 0.1);
% disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x3all(:, 3), 'BinWidth', 0.1);
% disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x3all(:, 4), 'BinWidth', 0.1);
% disp(h_petal_width)
title('Petal width');




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

t1 = [1 0 0]';
t2 = [0 1 0]';
t3 = [0 0 1]';

training_data = cell(N_training*C, 2);
for i = 1:N_training
   x1_i = [x1_training_labeled.Var2(i) x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var2(i) x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var2(i) x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :) = {x1_i, t1};
   training_data(i + N_training, :) = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Set up training, again...
x1_training = x1all(1:N_training, 2:end);
x2_training = x2all(1:N_training, 2:end);
x3_training = x3all(1:N_training, 2:end);

% Set up tests
x1_test = x1all(N_training + 1:end, 2:end);
x2_test = x2all(N_training + 1:end, 2:end);
x3_test = x3all(N_training + 1:end, 2:end);



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

disp("Features: [Sepal width (cm), Petal length (cm), Petal width (cm)]")

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


disp("-------------------")
disp("-------------------")

%% Taking away the next feature - Sepal width

% Setting up
N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;
D = 2;


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
   x1_i = [x1_training_labeled.Var3(i) x1_training_labeled.Var4(i)]'; 
   x2_i = [x2_training_labeled.Var3(i) x2_training_labeled.Var4(i)]'; 
   x3_i = [x3_training_labeled.Var3(i) x3_training_labeled.Var4(i)]'; 
   training_data(i, :) = {x1_i, t1};
   training_data(i + N_training, :) = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Set up training, again...
x1_training = x1all(1:N_training, 3:end);
x2_training = x2all(1:N_training, 3:end);
x3_training = x3all(1:N_training, 3:end);

% Set up tests
x1_test = x1all(N_training + 1:end, 3:end);
x2_test = x2all(N_training + 1:end, 3:end);
x3_test = x3all(N_training + 1:end, 3:end);



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

disp("Features: [Petal length (cm), Petal width (cm)]")

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


disp("-------------------")
disp("-------------------")

%% Taking away the next feature - Sepal width

% Setting up
N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;
D = 1;


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
   x1_i = x1_training_labeled.Var4(i)'; 
   x2_i = x2_training_labeled.Var4(i)'; 
   x3_i = x3_training_labeled.Var4(i)'; 
   training_data(i, :) = {x1_i, t1};
   training_data(i + N_training, :) = {x2_i, t2};
   training_data(i + 2*N_training, :) = {x3_i, t3};
end

% Set up training, again...
x1_training = x1all(1:N_training, 4:end);
x2_training = x2all(1:N_training, 4:end);
x3_training = x3all(1:N_training, 4:end);

% Set up tests
x1_test = x1all(N_training + 1:end, 4:end);
x2_test = x2all(N_training + 1:end, 4:end);
x3_test = x3all(N_training + 1:end, 4:end);



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
disp("Features: [Petal width (cm)]")

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


