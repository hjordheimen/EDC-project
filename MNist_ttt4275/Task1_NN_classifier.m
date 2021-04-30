clc;
clear;
%% Initializing and set up
load('data_all.mat');
C = 10;                 % Number of classes, 0-9

chunk_size = 1000;
N = num_test/chunk_size;

% Store results in order to display them later
correctly_classified_numbers = NaN(1, num_test);
misclassified_numbers = NaN(1, num_test);

confusion_matrix = zeros(C, C);

%% Run NN classifier on testv with trainv as template (takes ~30min to run)
tic
for k = 1:N
    disp(k);
    
    chunk_base_index = (k - 1)*chunk_size;
    % Use entire training set as templates
    templates = trainv;                      
    test_chunk = testv(chunk_base_index + 1:k*chunk_size, :);
    
    % Each column of Z holds the distance to all templates for one test sample
    % min extracts the index of the NN for each sample
    Z = dist(templates, test_chunk');        
    [~, I] = min(Z);                         
    
    for sample_chunk_index = 1:chunk_size
        sample_index = chunk_base_index + sample_chunk_index;
        class = trainlab(I(sample_chunk_index));
        label = testlab(sample_index);
        
        if class == label
            correctly_classified_numbers(sample_index) = class;
        else
            misclassified_numbers(sample_index) = class;
        end
        
        confusion_matrix(label + 1, class + 1) = confusion_matrix(label + 1, class + 1) + 1;
    end
end
toc

error_rate = 1-(trace(confusion_matrix)/num_test);

disp("Confusion matrix:")
disp(confusion_matrix)
disp("Error rate:")
disp(error_rate)
