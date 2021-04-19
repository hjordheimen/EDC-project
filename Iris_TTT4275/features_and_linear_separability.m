clc
clear

%% Initializing and setup

x1all = load('class_1','-ascii'); % Iris Setosa
x2all = load('class_2','-ascii'); % Iris Versicolor
x3all = load('class_3','-ascii'); % Iris Virginica



N = size(x1all, 1);
N_training = 30;
N_test = N - N_training;
C = 3;



%% Histogram for each feature as a whole

% Don't know how many bins we should us.. Using 'BinWidth', 0.1 for now.

figure(1);
sgtitle("All iris'")
% Sepal length histogram
subplot(221);
h_sepal_length = histogram([x1all(:, 1); x2all(:, 1); x3all(:, 1)], 'BinWidth', 0.1);
disp(h_sepal_length)
title('Sepal length histogram');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram([x1all(:, 2); x2all(:, 2); x3all(:, 2)], 'BinWidth', 0.1);
disp(h_sepal_width)
title('Sepal width histogram');

% Petal length histogram
subplot(223);
h_petal_length = histogram([x1all(:, 3); x2all(:, 3); x3all(:, 3)], 'BinWidth', 0.1);
disp(h_petal_length)
title('Petal length histogram')

% Petal width histogram
subplot(224);
h_petal_width = histogram([x1all(:, 4); x2all(:, 4); x3all(:, 4)], 'BinWidth', 0.1);
disp(h_petal_width)
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

%% Iris Setosa histogram
figure(2);
sgtitle('Iris Setosa')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x1all(:, 1), 'BinWidth', 0.1);
disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x1all(:, 2), 'BinWidth', 0.1);
disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x1all(:, 3), 'BinWidth', 0.1);
disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x1all(:, 4), 'BinWidth', 0.1);
disp(h_petal_width)
title('Petal width');


%% Iris Versicolor histogram

figure(3);
sgtitle('Iris Versicolor')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x2all(:, 1), 'BinWidth', 0.1);
disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x2all(:, 2), 'BinWidth', 0.1);
disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x2all(:, 3), 'BinWidth', 0.1);
disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x2all(:, 4), 'BinWidth', 0.1);
disp(h_petal_width)
title('Petal width');

%% Iris Virginica histogram
figure(4);
sgtitle('Iris Virginica')
% Sepal length histogram
subplot(221);
h_sepal_length = histogram(x3all(:, 1), 'BinWidth', 0.1);
disp(h_sepal_length)
title('Sepal length');

% Sepal width histogram
subplot(222);
h_sepal_width = histogram(x3all(:, 2), 'BinWidth', 0.1);
disp(h_sepal_width)
title('Sepal width');

% Petal length histogram
subplot(223);
h_petal_length = histogram(x3all(:, 3), 'BinWidth', 0.1);
disp(h_petal_length)
title('Petal length')

% Petal width histogram
subplot(224)
h_petal_width = histogram(x3all(:, 4), 'BinWidth', 0.1);
disp(h_petal_width)
title('Petal width');




