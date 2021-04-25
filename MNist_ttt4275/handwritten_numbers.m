clc;
clear;
%% Initializing and set up
load('data_all.mat');
C = 10;



%% Dette trengs kanskje ikke?

% Set up training data

% training_data = cell(num_train, 2);
% for i = 1:num_train
%    number_i = trainv(i, :);
%    label_i = trainlab(i);
%    training_data(i, :) = {number_i, label_i};
% end

%% Finding the nearest neighbours 
% classified_numbers = nan(num_test, 1);
% confusion_matrix = zeros(C, C);
% error_count = 0;

% %% Dette gikk rett vest... Må nok bruke dist, som jeg så rett etter å ha kjørt i 10 min...
% for n = 1:1000
%     NN_index = 1;
%     NN = (testv(1, :)' - trainv(NN_index, :)' )'*(testv(1, :)' - trainv(NN_index, :)' );
%     for i = 1:num_train    
%         new_NN = (testv(1, :)' - trainv(i, :)')'*(testv(1, :)' - trainv(i, :)');
%         if new_NN < NN
%            NN_index =  i;
%            NN = new_NN;
%         end
%     end
%     disp(n);
%     % The +1 is due to zero is one of the numbers ;)
%     confusion_matrix(testlab(n) + 1, trainlab(NN_index) + 1) = confusion_matrix(testlab(n) + 1, trainlab(NN_index) + 1) + 1;
% %     classified_numbers(n) = trainlab(NN_index);
% end

% for i = 1:C
%     error_count = error_count +  num_test - confusion_matrix_testing(i, i);
% end

%% Using dist to calculate Euclidian distance

chunk_size = 1000;
N = num_test/chunk_size;

classified_number = zeros(1, num_test);

% Husk å gjøre dette her....
misclassified_index = zeros(1, num_test);

confusion_matrix = zeros(C, C);

for k = 1:N
    disp(k);
    Z = dist(trainv, testv((k - 1)*chunk_size + 1:k*chunk_size, :)');
    [M, I] = min(Z);
    for i = 1:chunk_size
%         classified_number((k - 1)*chunk_size + i) = trainlab(I(i));
        confusion_matrix(testlab((k - 1)*chunk_size + i) + 1, trainlab(I(i)) + 1) = confusion_matrix(testlab((k - 1)*chunk_size + i) + 1, trainlab(I(i)) + 1) + 1;
    end
end

% 
% disp(trainlab(NN_index));
% disp(testlab(1));



disp("Confusion matrix:")
disp(confusion_matrix)
% disp("Error count:")
% disp(error_count)
