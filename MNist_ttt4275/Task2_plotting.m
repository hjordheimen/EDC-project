%% Displaying some clustered samples
% Run the clustering script first!

%close all
classes_to_display = [4];
pictures_of_each_class = 32;
x = zeros(28,28); 

for j = classes_to_display
    for i = 1:pictures_of_each_class
        x(:)= new_trainv(j*M+i, :);    
        figure(j*M+i);
        image(x');
    end
end

%% Plot of chosen clusters
% Run the clustering script first!

close all

indices = [277 314 274 451 503 488 588 633 628];
x = zeros(28,28); 

figure(3);
for i = 1:length(indices)
    x(:)= new_trainv(indices(i), :);
    subplot(3,3,i)
    image(x');
    if i <= 3
        str = "Cluster of 4s";
    elseif (i > 3) && (i <=6)
        str = "Cluster of 7s";
    else
        str = "Cluster of 9s";
    end
    title(str)
end