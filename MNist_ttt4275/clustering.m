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

% Cumulativ sum of number indices
x = zeros(1, C);
for i = 1:num_train
    x(trainlab(i) + 1) = x(trainlab(i) + 1) + 1;
end

class_indices = cumsum(x);
class_indices = [0 class_indices];

% Generate clusters

new_trainv = NaN(M*C, vec_size);

for i = 1:C
    class_i = sorted_training_data(class_indices(i) + 1:class_indices(i + 1), :);
    [~, new_trainv((i - 1)*M + 1:i*M, :)] = kmeans(class_i, M);
end


%% Finding the confusion matrix and error rate, using NN classifier using the clusters as templates. 

% misclassified_index = zeros(1, num_test);

confusion_matrix = zeros(C, C);

Z = dist(new_trainv, testv');
[M, I] = min(Z);

for i = 1:num_test
%         classified_number((k - 1)*chunk_size + i) = trainlab(I(i));
    confusion_matrix(testlab(i) + 1, trainlab(I(i)) + 1) = confusion_matrix(testlab(i) + 1, trainlab(I(i)) + 1) + 1;
end


error_count = num_test - trace(confusion_matrix);


disp("Confusion matrix:");
disp(confusion_matrix);
disp("Error rate:");
disp(error_count/num_test);
