clc
clear

%% Initializing and set up
load('data_all.mat');

C = 10;
M = 64; % # Clusters

% Set up training data

training_data = cell(num_train, 2);
for i = 1:num_train
   number_i = trainv(i, :);
   label_i = trainlab(i);
   training_data(i, :) = {number_i, label_i};
end

training_data = sortrows(training_data, 2);
sorted_training_data = cell2mat(training_data(:, 1));

% Count the number of examples for each class
num_examples = zeros(1, C);
for i = 1:num_train
    num_examples(trainlab(i) + 1) = num_examples(trainlab(i) + 1) + 1;
end
class_indices = cumsum(num_examples);
class_indices = [0 class_indices];       % Add zero as the first index to indicate the start of the first class


% Generate clusters

new_trainv = NaN(M*C, vec_size);

for i = 1:C
    class_i = sorted_training_data(class_indices(i) + 1:class_indices(i + 1), :);
    [~, new_trainv((i - 1)*M + 1:i*M, :)] = kmeans(class_i, M);
end


% Creating new_trainlab, sorted
new_trainlab = [ zeros(M, 1); 
                  ones(M, 1); 
                2*ones(M, 1); 
                3*ones(M, 1); 
                4*ones(M, 1); 
                5*ones(M, 1); 
                6*ones(M, 1); 
                7*ones(M, 1); 
                8*ones(M, 1); 
                9*ones(M, 1); ];


%% Checking the images of new_trainv
% 
% 
% x = zeros(28,28); 
% for i = 1:8
%     x(:)= new_trainv(i*i, :);
%     figure(i);
%     image(x');
% end

%% Finding the confusion matrix and error rate, using NN classifier using the clusters as templates. 

confusion_matrix = zeros(C, C);

Z = dist(new_trainv, testv');
[~, I] = min(Z);

for i = 1:num_test
    class = new_trainlab(I(i));
    label = testlab(i);
    
    % +1 is due to the indexing starting at 1.
    confusion_matrix(label + 1, class + 1) = confusion_matrix(label + 1, class + 1) + 1;
end


error_rate_cluster = 1 - (trace(confusion_matrix)/num_test);

disp("Confusion matrix, clustering:");
disp(confusion_matrix);
disp("Error rate, clustering:");
disp(error_rate_cluster);


%% 7NN
K = 7;


confusion_matrix_7NN = zeros(C, C);
NN = NaN(1, K);

Z = dist(new_trainv, testv');
[~, I] = mink(Z, K);

for i = 1:num_test
    for j = 1:K
       NN(j) = new_trainlab(I(j, i)); 
    end
    class = mode(NN);
    label = testlab(i);
        
    confusion_matrix_7NN(label + 1, class + 1) = confusion_matrix_7NN(label + 1, class + 1) + 1;
end

error_rate_7NN = 1 - (trace(confusion_matrix_7NN)/num_test);

disp("Confusion matrix, 7NN:");
disp(confusion_matrix_7NN);
disp("Error rate, 7NN:");
disp(error_rate_7NN);


