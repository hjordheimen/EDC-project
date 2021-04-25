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
confusion_matrix = zeros(C, C);
error_count = 0;

%% Dette gikk rett vest... Må nok bruke dist, som jeg så rett etter å ha kjørt i 10 min...
% for n = 1:num_test
%     NN_index = 1;
%     for i = 1:num_train
%         NN = (testv(1, :)' - trainv(NN_index, :)' )'*(testv(1, :)' - trainv(NN_index, :)' );
%         new_NN = (testv(1, :)' - trainv(i, :)')'*(testv(1, :)' - trainv(i, :)');
%         if new_NN < NN
%            NN_index =  i;
%         end
%     end
%     % The +1 is due to zero is one of the numbers ;)
%     confusion_matrix(testlab(n) + 1, trainlab(NN_index) + 1) = confusion_matrix(testlab(n) + 1, trainlab(NN_index) + 1) + 1;
% %     classified_numbers(n) = trainlab(NN_index);
% end

% for i = 1:C
%     error_count = error_count +  num_test - confusion_matrix_testing(i, i);
% end

disp("Confusion matrix:")
disp(confusion_matrix)
disp("Error count:")
disp(error_count)
