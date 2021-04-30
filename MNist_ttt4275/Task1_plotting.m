%% Display some misclassified images
clc
clear
close all

load('data_all.mat');
load('KNN1_misclassified_numbers.mat')

% Displaying more than 30 images at once can make Matlab stall
num_images_to_display = 30;
base_index = 100;

images_displayed = 0;
x = zeros(row_size, col_size);

for i = base_index:num_test
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

% Displaying more than 30 images at once can make Matlab stall
num_images_to_display = 30;
base_index = 8000;

images_displayed = 0;
x = zeros(row_size, col_size);

for i = base_index:num_test
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

%% Figure comparing 4 and 9
clc
clear
close all

load('data_all.mat');

indices = [116 448 13 21];
strs = ["Classified as 9, label is 4";
        "Classified as 9, label is 4";
        "Correctly classified as 9"  ;
        "Correctly classified as 9"  ;];
x = zeros(row_size, col_size);

figure(1)
for i = 1:length(indices)
    subplot(2,2,i)
    x(:) = testv(indices(i),:);
    image(x')
    str = strs(i);
    title(str)
end

%% Figure of impressive classifcations
clc
clear
close all

load('data_all.mat');

indices = [44 4008 8000 8001];

x = zeros(row_size, col_size);

figure(2)
for i = 1:length(indices)
    subplot(2,2,i)
    x(:) = testv(indices(i),:);
    image(x')
    str = "Correctly classified as "+int2str(testlab(indices(i)));
    title(str)
end

%% Figure of misclassifcations
clc
clear
close all

load('data_all.mat');
load('KNN1_misclassified_numbers.mat')

% Three first are understable misses, three last are wierd to miss on
indices = [359 446 741 480 269 342];

x = zeros(row_size, col_size);

figure(2)
for i = 1:length(indices)
    subplot(2,3,i)
    x(:) = testv(indices(i),:);
    image(x')
    str = "Classified as "+int2str(misclassified_numbers(indices(i)));
    str = str + ", label is " + int2str(testlab(indices(i)));
    title(str)
end
