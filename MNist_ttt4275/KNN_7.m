clc
clear

%% KNN classifier with K = 7

load('data_all.mat');
C = 10;
K = 7;


chunk_size = 1000;
N = num_test/chunk_size;

% classified_number = zeros(1, num_test);

confusion_matrix = zeros(C, C);
NN = NaN(1, 7);
for k = 1:N
    
    Z = dist(trainv, testv((k - 1)*chunk_size + 1:k*chunk_size, :)');
    [M, I] = mink(Z, 7);
    for i = 1:chunk_size
        for j = 1:K
           NN(j) = trainlab(I(j, i)); 
        end
        classified_number = mode(NN);
        
        confusion_matrix(testlab((k - 1)*chunk_size + i) + 1, classified_number + 1) = confusion_matrix(testlab((k - 1)*chunk_size + i) + 1, classified_number + 1) + 1;
    end
    disp(k + "/" + N + " done");
end


error_rate = trace(confusion_matrix)/num_test;


disp("Confusion matrix:")
disp(confusion_matrix)
disp("Error rate:")
disp(error_rate/num_test)