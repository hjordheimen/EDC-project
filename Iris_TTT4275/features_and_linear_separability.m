clc
clear

%% Initializing and setup

x1all = load('class_1','-ascii');
x2all = load('class_2','-ascii');
x3all = load('class_3','-ascii');



N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;



%% Histogram for each feature and class

% Don't know how many bins we should us.. Using 25 for now.
% Sepal length histogram
figure(1);
h_sepal_length = histogram([x1all(:, 1); x2all(:, 1); x3all(:, 1)], 25);
disp(h_sepal_length)
title('Sepal length histogram');

% Sepal width histogram
figure(2);
h_sepal_width = histogram([x1all(:, 2); x2all(:, 2); x3all(:, 2)], 25);
xscale
disp(h_sepal_width)
title('Sepal width histogram');

% Petal length histogram
figure(3);
h_petal_length = histogram([x1all(:, 3); x2all(:, 3); x3all(:, 3)], 25);
disp(h_petal_length)
title('Petal length histogram')

% Petal width histogram
figure(4);
h_petal_width = histogram([x1all(:, 4); x2all(:, 4); x3all(:, 4)], 25);
disp(h_petal_width)
title('Petal width histogram');


% Usikker på om vi skal normalisere hvert enkelt histogram, slik at vi kan
% sammenligne dem på en god måte, for så å kutte en feature...

% Usikker på hvordan vi skal lage histogram for hver klasse. Er det slik at
% vi skal lage Histogram for hver av sepal og petal for hver klasse?

% Iris Setosa histogram

% Iris Versicolor histogram

% Iris Virginica histogram





