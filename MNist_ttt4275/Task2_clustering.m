clc
clear

%% Initializing and set up
load('data_all.mat');

C = 10; % # of classes
M = 64; % # of clusters

% Match training samples and labels in a cell array
training_data = cell(num_train, 2);
for sample_index = 1:num_train
   number_i = trainv(sample_index, :);
   label_i = trainlab(sample_index);
   training_data(sample_index, :) = {number_i, label_i};
end

% Sort the training data by label
training_data = sortrows(training_data, 2);
sorted_training_data = cell2mat(training_data(:, 1));

% Count the number of samples from each class
num_examples = zeros(1, C);
for sample_index = 1:num_train
    num_examples(trainlab(sample_index) + 1) = num_examples(trainlab(sample_index) + 1) + 1;
end

% Generate start index of each class
% Zero indicates the start of the first class
class_indices = cumsum(num_examples);
class_indices = [0 class_indices];


% Generate clusters and insert them into the new training set
new_trainv = NaN(M*C, vec_size);

for sample_index = 1:C
    class_i = sorted_training_data(class_indices(sample_index) + 1:class_indices(sample_index + 1), :);
    [~, new_trainv((sample_index - 1)*M + 1:sample_index*M, :)] = kmeans(class_i, M);
end


% Creating new labels for training set
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

%% Run NN classifier using the clusters as templates
tic
confusion_matrix_NN = zeros(C, C);

% Use the clustered samples as templates
% Each column of Z holds the distance to all templates for one test sample
% min extracts the index of the NN for each sample
Z = dist(new_trainv, testv');
[~, I] = min(Z);

for sample_index = 1:num_test
    class = new_trainlab(I(sample_index));
    label = testlab(sample_index);
    
    % +1 is due to the indexing starting at 1.
    confusion_matrix_NN(label + 1, class + 1) = confusion_matrix_NN(label + 1, class + 1) + 1;
end


error_rate_NN = 1 - (trace(confusion_matrix_NN)/num_test);

toc

disp("Confusion matrix, clustering:");
disp(confusion_matrix_NN);
disp("Error rate, clustering:");
disp(error_rate_NN);


%% KNN - calculate distances and extract NN indices

K = 7;

% Each column of Z holds the distance to all templates for one test sample
% mink extracts the indices of the KNNs for each sample
Z = dist(new_trainv, testv');
[~, I] = mink(Z, K);


%% KNN Method 1
% If multiple classes are most frequent, choose most 
% frequent lowest class

confusion_matrix_KNN_1 = zeros(C, C);

% For each sample
for sample_index = 1:num_test
  
    NN_classes = NaN(1, K);
    for nn = 1:K
       NN_classes(nn) = new_trainlab(I(nn, sample_index)); 
    end
    
    % choose most frequent lowest class
    predicted_class = mode(NN_classes); 
    label = testlab(sample_index);
        
    confusion_matrix_KNN_1(label + 1, predicted_class + 1) = confusion_matrix_KNN_1(label + 1, predicted_class + 1) + 1;
end

error_rate_1 = 1 - (trace(confusion_matrix_KNN_1)/num_test);

disp("Confusion matrix 1:");
disp(confusion_matrix_KNN_1);
disp("Error rate 1:");
disp(error_rate_1);


%% KNN Method 2
% If multiple classes are most frequent, choose most 
% frequent class with lowest total distance to sample

confusion_matrix_KNN_2 = zeros(C, C);

% For each sample
for sample_index = 1:num_test
 
    NN_class_and_dist_count = zeros(2,C);
    
    % Count the number of NNs from each class and the total distance
    % from the sample to each class among the NNs.
    for nn = 1:K
       NN_class = new_trainlab(I(nn, sample_index));
       NN_dist = Z(I(nn,sample_index));
       NN_class_and_dist_count(1,NN_class+1) = NN_class_and_dist_count(1,NN_class+1) + 1;
       NN_class_and_dist_count(2,NN_class+1) = NN_class_and_dist_count(2,NN_class+1) + NN_dist;
    end
    
    % Find the most frequent class. If several, choose the nearest one
    predicted_class = NaN;
    max_count = 0;
    min_dist  = inf; 
    for class = 0:C-1
        class_count = NN_class_and_dist_count(1,class+1);
        class_dist  = NN_class_and_dist_count(2,class+1);
        if class_count > max_count
            max_count = class_count;
            min_dist  = class_dist;
            predicted_class = class;
        elseif (class_count == max_count) && (class_dist < min_dist)
            max_count = class_count;
            min_dist  = class_dist;
            predicted_class = class;
        end
    end

    label = testlab(sample_index);
        
    confusion_matrix_KNN_2(label + 1, predicted_class + 1) = confusion_matrix_KNN_2(label + 1, predicted_class + 1) + 1;
end

error_rate_2 = 1 - (trace(confusion_matrix_KNN_2)/num_test);

disp("Confusion matrix 2:");
disp(confusion_matrix_KNN_2);
disp("Error rate 2:");
disp(error_rate_2);

%% KNN Method 3
% If multiple classes are most frequent, choose most 
% frequent class with lowest single distance to sample

confusion_matrix_KNN_3 = zeros(C, C);

% For each sample
for sample_index = 1:num_test

    NN_class_count = zeros(1,C);
    NN_min_dist = inf*ones(1,C);
    NN_class_count_and_min_dist = [NN_class_count; NN_min_dist];
    
    % Count the number of NNs from each class. Store the lowest single
    % distance from the sample to each class among the NNs.
    for nn = 1:K
       NN_class = new_trainlab(I(nn, sample_index));
       NN_dist = Z(I(nn,sample_index));
       NN_class_count_and_min_dist(1,NN_class+1) = NN_class_count_and_min_dist(1,NN_class+1) + 1;
       if NN_dist <  NN_class_count_and_min_dist(2,NN_class+1)
           NN_class_count_and_min_dist(2,NN_class+1) = NN_dist;
       end
    end
    
    % Find the most frequent class. If several, choose the nearest one
    predicted_class = NaN;
    max_count = 0;
    min_dist  = inf; 
    for class = 0:C-1
        class_count = NN_class_count_and_min_dist(1,class+1);
        min_class_dist  = NN_class_count_and_min_dist(2,class+1);
        if class_count > max_count
            max_count = class_count;
            min_dist  = min_class_dist;
            predicted_class = class;
        elseif (class_count == max_count) && (min_class_dist < min_dist)
            max_count = class_count;
            min_dist  = min_class_dist;
            predicted_class = class;
        end
    end

    label = testlab(sample_index);
        
    confusion_matrix_KNN_3(label + 1, predicted_class + 1) = confusion_matrix_KNN_3(label + 1, predicted_class + 1) + 1;
end

error_rate_3 = 1 - (trace(confusion_matrix_KNN_3)/num_test);

disp("Confusion matrix 3:");
disp(confusion_matrix_KNN_3);
disp("Error rate 3:");
disp(error_rate_3);

