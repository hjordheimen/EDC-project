clc;
clear;
%% Initializing and set up
load('data_all.mat');
C = 10;                 % Number of classes, 0-9

chunk_size = 1000;
N = num_test/chunk_size;

% The index of each element specifies the index of the test sample in testv
% The element at that index specifies the number which that sample is
% classified as
correctly_classified_numbers = NaN(1, num_test);
misclassified_numbers = NaN(1, num_test);

confusion_matrix = zeros(C, C);

%% Run NN classifier on testv with trainv as template (takes ~30min to run)
tic
for k = 1:N
    disp(k);
    
    chunk_base_index = (k - 1)*chunk_size;
    template = trainv;
    test_chunk = testv(chunk_base_index + 1:k*chunk_size, :);
    
    Z = dist(template, test_chunk');        % Each column of Z holds the distance to each template sample for one test sample
    [~, I] = min(Z);                        % Exctract index of the NN for each sample
    
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


%% Disp
disp("Confusion matrix:")
disp(confusion_matrix)
disp("Error rate:")
disp(error_rate)

%% Display some misclassified images
clc
clear
close all

load('data_all.mat');
load('KNN1_misclassified_numbers.mat')

num_images_to_display = 20;

images_displayed = 0;
x = zeros(row_size, col_size);

for i = 1:num_test
    if ~(isnan(misclassified_numbers(i)))
        x(:) = testv(i,:);
        figure(i)
        image(x')
        str = "Classified as "+int2str(misclassified_numbers(i));
        str = str + ", label is " + int2str(testlab(i));
        title(str)
        images_displayed = images_displayed + 1;
    end
    if images_displayed > num_images_to_display
        break
    end
end

%% Display some correctly classified images
clc
clear
close all

load('data_all.mat');
load('KNN1_correctly_classified_numbers.mat')

num_images_to_display = 20;

images_displayed = 0;
x = zeros(row_size, col_size);

for i = 1:num_test
    if ~(isnan(correctly_classified_numbers(i)))
        x(:) = testv(i,:);
        figure(i)
        image(x')
        str = "Correctly classified as "+int2str(correctly_classified_numbers(i));
        title(str)
        images_displayed = images_displayed + 1;
    end
    if images_displayed > num_images_to_display
        break
    end
end

